package com.uhu.saluhud.saluhud.database.updater.service;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudSystemService 
{
    public SaluhudDatabaseInformation getSaluhudDatabaseInformation()
    {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MMM/yyyy");
        
        String sql = "SELECT database_version, database_date FROM SALUHUD_SYSTEM_METADATA";

        List<Object[]> result = SaluhudDatabaseInformation.em.createNativeQuery(sql).getResultList();

        String databaseVersion = "unknown";
        String databaseDateString = "unknown";
        
        for (Object[] row : result)
        {
            databaseVersion = (String) row[0];
            Date databaseDate = (Date) row[1];
            
            if(databaseDate != null)
            {
                databaseDateString = formatter.format(databaseDate);
            }   
        }
        
        return new SaluhudDatabaseInformation(databaseVersion, databaseDateString, "NONE", "NONE", "NONE");
    }
    
    public String getDatabaseUpdaterVersion()
    {
        Properties databaseUpdateMetadata = new Properties();
        
        try(InputStream databaseUpdateMetadataInputStream = 
                Thread.currentThread().getContextClassLoader().getResourceAsStream("database/database_update_metadata.properties"))
        {
            databaseUpdateMetadata.load(databaseUpdateMetadataInputStream);
            
            return databaseUpdateMetadata.getProperty("saluhud.database.updater.version");
        }
        catch(IOException ex)
        {
            Logger.getLogger(SaluhudSystemService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return "unknown";
    }
    
    public String getDatabaseVersionAfterUpdate(DatabaseUpdateSQLDocument sqlDocument)
    {
        List<DatabaseUpdateSQLStatement> sqlStatements = sqlDocument.getSQLStatements();
        
        DatabaseUpdateSQLStatement lastSQLStatement = sqlStatements.get(sqlStatements.size() - 1);
        
        String databaseVersionAfterUpdate = lastSQLStatement.getStatement().substring(55, 60);
        
        return databaseVersionAfterUpdate;
    }

    public String getDatabaseVersionDateAfterUpdate(DatabaseUpdateSQLDocument sqlDocument)
    {
        List<DatabaseUpdateSQLStatement> sqlStatements = sqlDocument.getSQLStatements();
        
        DatabaseUpdateSQLStatement lastSQLStatement = sqlStatements.get(sqlStatements.size() - 1);
        
        String databaseVersionDateAfterUpdate = lastSQLStatement.getStatement().substring(80, 90);
        
        return databaseVersionDateAfterUpdate;
    }
}
