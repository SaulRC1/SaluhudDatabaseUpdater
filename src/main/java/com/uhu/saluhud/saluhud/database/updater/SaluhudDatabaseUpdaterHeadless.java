package com.uhu.saluhud.saluhud.database.updater;

import com.uhu.saluhud.saluhud.database.updater.bootstrap.SaluhudDatabaseUpdaterHibernateBootstrapper;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus;
import com.uhu.saluhud.saluhud.database.updater.logging.HeadlessDatabaseUpdateLogger;
import com.uhu.saluhud.saluhud.database.updater.logging.SaluhudDatabaseUpdateLogger;
import com.uhu.saluhud.saluhud.database.updater.parser.DatabaseUpdateSQLFileParser;
import com.uhu.saluhud.saluhud.database.updater.parser.SaluhudDatabaseUpdateFileParser;
import com.uhu.saluhud.saluhud.database.updater.service.SaluhudSystemService;
import com.uhu.saluhud.saluhud.database.updater.worker.UpdateDatabaseWorker;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Query;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.exception.JDBCConnectionException;
import org.hibernate.exception.SQLGrammarException;

/**
 *
 * @author SaulRC1
 */
public class SaluhudDatabaseUpdaterHeadless
{
    private static Logger logger = Logger.getLogger(SaluhudDatabaseUpdaterHeadless.class.getName());
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException
    {
        SaluhudDatabaseUpdaterHibernateBootstrapper saluhudDatabaseUpdaterHibernateBootstrapper
                = new SaluhudDatabaseUpdaterHibernateBootstrapper("SaluhudDatabaseUpdaterPersistenceUnit");
        
        logger.log(Level.INFO, "Connecting to Saluhud's database, please wait...");
        
        EntityManagerFactory entityManagerFactory;

        saluhudDatabaseUpdaterHibernateBootstrapper.initializeJpa();
            
        entityManagerFactory = saluhudDatabaseUpdaterHibernateBootstrapper.getEntityManagerFactory();
        
        SaluhudDatabaseInformation.emf = entityManagerFactory;
        SaluhudDatabaseInformation.em = SaluhudDatabaseInformation.emf.createEntityManager();
        
        logger.log(Level.INFO, "Connected to Saluhud's database successfully");
        
        logger.log(Level.INFO, "Parsing database update file...");
        
        SaluhudDatabaseUpdateFileParser<DatabaseUpdateSQLDocument> fileParser 
                = new DatabaseUpdateSQLFileParser();
        
        InputStream databaseUpdateFileInputStream = 
                Thread.currentThread().getContextClassLoader().getResourceAsStream("database/database_update.sql");
        
        DatabaseUpdateSQLDocument databaseUpdateDocument = fileParser.parseFile(databaseUpdateFileInputStream);
        
        SaluhudDatabaseInformation.databaseUpdateSQLDocument = databaseUpdateDocument;
        
        logger.log(Level.INFO, "Parsed database update file correctly.");
        
        logger.log(Level.INFO, "Retrieving Saluhud's database information...");
        
        SaluhudSystemService saluhudSystemService = new SaluhudSystemService();
        
        SaluhudDatabaseInformation saluhudDatabaseInformation = null;
        
        try
        {
            saluhudDatabaseInformation = saluhudSystemService.getSaluhudDatabaseInformation();
            
        } catch (SQLGrammarException e)
        {
            //If this exception is thrown then it normally means that the table
            //"SALUHUD_SYSTEM_METADATA" is not yet created. This can happen when
            //installing the database for the first time.
            saluhudDatabaseInformation = new SaluhudDatabaseInformation("unknown", "unknown", "NONE", "NONE", "NONE");
        }
        
        String databaseUpdaterVersion = saluhudSystemService.getDatabaseUpdaterVersion();
        saluhudDatabaseInformation.setSaluhudDatabaseUpdaterVersion(databaseUpdaterVersion);
        
        String databaseVersionAfterUpdate = saluhudSystemService.getDatabaseVersionAfterUpdate(SaluhudDatabaseInformation.databaseUpdateSQLDocument);
        saluhudDatabaseInformation.setDatabaseVersionAfterUpdate(databaseVersionAfterUpdate);
        
        String databaseVersionDateAfterUpdateString = saluhudSystemService.getDatabaseVersionDateAfterUpdate(SaluhudDatabaseInformation.databaseUpdateSQLDocument);
        
        LocalDate databaseVersionDateAfterUpdate = LocalDate.parse(databaseVersionDateAfterUpdateString);
        DateTimeFormatter databaseVersionDateAfterUpdateDateFormatter = DateTimeFormatter.ofPattern("dd/MMM/yyyy");
        
        saluhudDatabaseInformation.setDatabaseNewVersionDate(databaseVersionDateAfterUpdate.format(databaseVersionDateAfterUpdateDateFormatter));
        
        logger.log(Level.INFO, saluhudDatabaseInformation.toString());
        
        logger.log(Level.INFO, "Updating database...");
        
        updateDatabase(SaluhudDatabaseInformation.databaseUpdateSQLDocument);
        
        logger.log(Level.INFO, "Database updated.");
    }
    
    private static void updateDatabase(DatabaseUpdateSQLDocument databaseUpdateSQLDocument) 
    {
        SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement> headlessLogger = new HeadlessDatabaseUpdateLogger(logger);
        
        List<DatabaseUpdateSQLStatement> statements = databaseUpdateSQLDocument.getSQLStatements();
        
        for (DatabaseUpdateSQLStatement statement : statements)
        {
            try
            {
                SaluhudDatabaseInformation.em.getTransaction().begin();
            
                Query query = SaluhudDatabaseInformation.em.createNativeQuery(statement.getStatement());
            
                query.executeUpdate();
                
                SaluhudDatabaseInformation.em.getTransaction().commit();
                
                headlessLogger.log(statement, DatabaseUpdateLogMessageStatus.SUCCESS);
            }
            catch(JDBCConnectionException e)
            {
                logger.log(Level.SEVERE, "Connection error has occurred.");
            }
            catch (Exception e)
            {
                if (SaluhudDatabaseInformation.em.getTransaction().isActive())
                {
                    SaluhudDatabaseInformation.em.getTransaction().rollback();
                }
                
                headlessLogger.log(statement, DatabaseUpdateLogMessageStatus.FAILED);
            }
        }
        
        //Update SALUHUD_SYSTEM_METADATA updated_by_saluhud_database_updater_version
        //column
        SaluhudSystemService saluhudSystemService = new SaluhudSystemService();
        String updatedBySaluhudDatabaseUpdaterVersionStatement = "UPDATE SALUHUD_SYSTEM_METADATA SET "
                    + "updated_by_saluhud_database_updater_version = '" 
                    + saluhudSystemService.getDatabaseUpdaterVersion() + "' WHERE id = 1;";
        try
        {
            SaluhudDatabaseInformation.em.getTransaction().begin();
            
            Query query = SaluhudDatabaseInformation.em.createNativeQuery(updatedBySaluhudDatabaseUpdaterVersionStatement);

            query.executeUpdate();
            
            SaluhudDatabaseInformation.em.getTransaction().commit();

            headlessLogger.log(new DatabaseUpdateSQLStatement(LocalDate.now(), updatedBySaluhudDatabaseUpdaterVersionStatement),
                        DatabaseUpdateLogMessageStatus.SUCCESS);
        } 
        catch (Exception e)
        {
            if (SaluhudDatabaseInformation.em.getTransaction().isActive())
            {
                SaluhudDatabaseInformation.em.getTransaction().rollback();
            }

            
            headlessLogger.log(new DatabaseUpdateSQLStatement(LocalDate.now(), updatedBySaluhudDatabaseUpdaterVersionStatement), 
                        DatabaseUpdateLogMessageStatus.FAILED);
        }
    }
    
}
