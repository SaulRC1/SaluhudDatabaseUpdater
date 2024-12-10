package com.uhu.saluhud.saluhud.database.updater.worker;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus;
import com.uhu.saluhud.saluhud.database.updater.logging.SaluhudDatabaseUpdateLogger;
import com.uhu.saluhud.saluhud.database.updater.service.SaluhudSystemService;
import com.uhu.saluhud.saluhud.database.updater.ui.general.InformationDialog;
import com.uhu.saluhud.saluhud.database.updater.ui.general.handler.InformationDialogHandler;
import jakarta.persistence.Query;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.net.ConnectException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import javax.swing.SwingWorker;
import org.hibernate.exception.JDBCConnectionException;
import org.postgresql.util.PSQLException;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class UpdateDatabaseWorker extends SwingWorker<Void, Void> 
{
    private DatabaseUpdateSQLDocument databaseUpdateSQLDocument;
    private List<SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement>> loggers;
    private JFrame frame;
    private JButton updateButton;

    public UpdateDatabaseWorker(DatabaseUpdateSQLDocument databaseUpdateSQLDocument, 
            List<SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement>> loggers,
            JFrame frame, JButton updateButton)
    {
        this.databaseUpdateSQLDocument = databaseUpdateSQLDocument;
        this.loggers = loggers;
        this.frame = frame;
        this.updateButton = updateButton;
    }
    
    @Override
    protected Void doInBackground() throws Exception
    {
        List<DatabaseUpdateSQLStatement> statements = databaseUpdateSQLDocument.getSQLStatements();
        
        int totalStatements = statements.size();
        int currentStatementNumber = 1;
        
        for (DatabaseUpdateSQLStatement statement : statements)
        {
            try
            {
                SaluhudDatabaseInformation.em.getTransaction().begin();
            
                Query query = SaluhudDatabaseInformation.em.createNativeQuery(statement.getStatement());
            
                query.executeUpdate();
                
                SaluhudDatabaseInformation.em.getTransaction().commit();
                
                for (SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement> logger : loggers)
                {
                    logger.log(statement, DatabaseUpdateLogMessageStatus.SUCCESS);
                }
            }
            catch(JDBCConnectionException e)
            {
                Logger.getLogger(UpdateDatabaseWorker.class.getName()).log(Level.SEVERE, "Ha habido un error de conexion");
                
                SwingUtilities.invokeLater(() -> 
                {
                    InformationDialog connectionProblemDialog
                            = new InformationDialog(frame, "Connection error", "A connection error has occurred while updating "
                                    + "the database, please restart the program.", new Dimension(400, 200),
                                    new InformationDialogHandler()
                                    {
                                        @Override
                                        public void onOkPressed()
                                        {
                                            System.exit(-1);
                                        }
                                    });
                    
                    connectionProblemDialog.initialize();
                });
            }
            catch (Exception e)
            {
                Logger.getLogger(UpdateDatabaseWorker.class.getName()).log(Level.SEVERE, e.getMessage(), e);

                if (SaluhudDatabaseInformation.em.getTransaction().isActive())
                {
                    SaluhudDatabaseInformation.em.getTransaction().rollback();
                }
                
                for (SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement> logger : loggers)
                {
                    logger.log(statement, DatabaseUpdateLogMessageStatus.FAILED);
                }
            }
            
            setProgress((currentStatementNumber * 100) / totalStatements);
            currentStatementNumber++;
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
            
            for (SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement> logger : loggers)
            {
                logger.log(new DatabaseUpdateSQLStatement(LocalDate.now(), updatedBySaluhudDatabaseUpdaterVersionStatement),
                        DatabaseUpdateLogMessageStatus.SUCCESS);
            }
        } 
        catch (Exception e)
        {
            Logger.getLogger(UpdateDatabaseWorker.class.getName()).log(Level.SEVERE, e.getMessage(), e);

            if (SaluhudDatabaseInformation.em.getTransaction().isActive())
            {
                SaluhudDatabaseInformation.em.getTransaction().rollback();
            }

            for (SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement> logger : loggers)
            {
                logger.log(new DatabaseUpdateSQLStatement(LocalDate.now(), updatedBySaluhudDatabaseUpdaterVersionStatement), 
                        DatabaseUpdateLogMessageStatus.FAILED);
            }
        }
        
        return null;
    }

    @Override
    protected void done()
    {
        Toolkit.getDefaultToolkit().beep();
        this.updateButton.setEnabled(true);
        frame.setCursor(Cursor.getDefaultCursor());
    }

    
}
