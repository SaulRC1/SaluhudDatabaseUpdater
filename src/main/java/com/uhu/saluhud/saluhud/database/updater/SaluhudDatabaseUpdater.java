package com.uhu.saluhud.saluhud.database.updater;

import com.uhu.saluhud.saluhud.database.updater.bootstrap.SaluhudDatabaseUpdaterHibernateBootstrapper;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseExecutorService;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.ui.SaluhudDatabaseUpdaterMainFrame;
import com.uhu.saluhud.saluhud.database.updater.ui.general.InformationDialog;
import com.uhu.saluhud.saluhud.database.updater.ui.general.LoadingDialog;
import com.uhu.saluhud.saluhud.database.updater.ui.general.handler.DisposeInformationDialogHandler;
import com.uhu.saluhud.saluhud.database.updater.ui.general.handler.InformationDialogHandler;
import com.uhu.saluhud.saluhud.database.updater.worker.InitializeDatabaseConnectionWorker;
import com.uhu.saluhud.saluhud.database.updater.worker.ParseDatabaseUpdateFileWorker;
import com.uhu.saluhud.saluhud.database.updater.worker.RetrieveDatabaseInformationWorker;
import jakarta.persistence.EntityManagerFactory;
import java.awt.Dimension;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import javax.swing.SwingWorker;

/**
 *
 * @author SaulRC1
 */
public class SaluhudDatabaseUpdater
{

    public static void main(String[] args)
    {   
        System.setProperty( "sun.java2d.uiScale", "1.0" );
        
        ExecutorService executorService = SaluhudDatabaseExecutorService.executorService;
        
        SwingUtilities.invokeLater(() -> 
        {
            SaluhudDatabaseUpdaterMainFrame mainFrame = 
                    new SaluhudDatabaseUpdaterMainFrame(800, 600, 800, 600, "Saluhud Database Updater");
            
            mainFrame.initialize();
            
            LoadingDialog initializeDatabaseConnectionLoadingDialog = new LoadingDialog(mainFrame, 
                    "Database connection", "Connecting to Saluhud's database, please wait.");
            
            SaluhudDatabaseUpdaterHibernateBootstrapper saluhudDatabaseUpdaterHibernateBootstrapper
                = new SaluhudDatabaseUpdaterHibernateBootstrapper("SaluhudDatabaseUpdaterPersistenceUnit");
            
            SwingWorker<EntityManagerFactory, Void> databaseConnectionWorker = 
                    new InitializeDatabaseConnectionWorker(saluhudDatabaseUpdaterHibernateBootstrapper);
            
            executorService.submit(() -> 
            {
                databaseConnectionWorker.execute();
                
                try
                {
                    SaluhudDatabaseInformation.emf = databaseConnectionWorker.get();
                    SaluhudDatabaseInformation.em = SaluhudDatabaseInformation.emf.createEntityManager();
                    
                    initializeDatabaseConnectionLoadingDialog.dispose();
                    
                    executeParseDatabaseUpdateFile(executorService, mainFrame);
                    
                } catch (InterruptedException | ExecutionException ex)
                {
                    Logger.getLogger(SaluhudDatabaseUpdater.class.getName()).log(Level.SEVERE, null, ex);
                    initializeDatabaseConnectionLoadingDialog.dispose();
                    
                    SwingUtilities.invokeLater(() -> 
                    {
                        InformationDialog connectionFailedDialog
                                = new InformationDialog(mainFrame, "Connection failed", "Connection to Saluhud's database failed."
                                        + " Please check your network or if the database is online and execute Saluhud Database Updater again.",
                                        new Dimension(400, 200), new InformationDialogHandler()
                                {
                                    @Override
                                    public void onOkPressed()
                                    {
                                        System.exit(-1);
                                    }
                                });
                        
                        connectionFailedDialog.initialize();
                    });
                }
            });
            
            initializeDatabaseConnectionLoadingDialog.initialize();
        });
    }
    
    private static void executeRetrieveDatabaseInformation(ExecutorService executorService, 
            SaluhudDatabaseUpdaterMainFrame mainFrame)
    {
        SwingUtilities.invokeLater(() ->
        {
            LoadingDialog retrieveDatabaseInformationLoadingDialog = new LoadingDialog(mainFrame,
                    "Database information", "Retrieving Saluhud's database information...");

            SwingWorker<SaluhudDatabaseInformation, Void> databaseInformationWorker
                    = new RetrieveDatabaseInformationWorker();

            executorService.submit(() ->
            {
                databaseInformationWorker.execute();

                try
                {
                    SaluhudDatabaseInformation databaseInformation = databaseInformationWorker.get();
                    
                    System.out.println("Database Information: " + databaseInformation.getDatabaseCurrentVersion());
                    
                    mainFrame.getSaluhudDatabaseUpdateMainJPanel().getDatabaseUpdateInformationJPanel()
                            .loadSaluhudDatabaseInformation(databaseInformation);

                    retrieveDatabaseInformationLoadingDialog.dispose();
                    
                    mainFrame.getSaluhudDatabaseUpdateMainJPanel().getDatabaseUpdateInformationJPanel().revalidate();
                } catch (InterruptedException | ExecutionException ex)
                {
                    Logger.getLogger(SaluhudDatabaseUpdater.class.getName()).log(Level.SEVERE, null, ex);
                    retrieveDatabaseInformationLoadingDialog.dispose();
                }
            });

            retrieveDatabaseInformationLoadingDialog.initialize();
        });
    }
    
    private static void executeParseDatabaseUpdateFile(ExecutorService executorService, 
            SaluhudDatabaseUpdaterMainFrame mainFrame)
    {
        SwingUtilities.invokeLater(() ->
        {
            LoadingDialog parseDatabaseUpdateFileLoadingDialog = new LoadingDialog(mainFrame,
                    "Database Update", "Parsing database update file...");

            SwingWorker<DatabaseUpdateSQLDocument, Void> parseDatabaseUpdateFileWorker
                    = new ParseDatabaseUpdateFileWorker();

            executorService.submit(() ->
            {
                parseDatabaseUpdateFileWorker.execute();

                try
                {
                    SaluhudDatabaseInformation.databaseUpdateSQLDocument = parseDatabaseUpdateFileWorker.get();

                    parseDatabaseUpdateFileLoadingDialog.dispose();
                    
                    executeRetrieveDatabaseInformation(executorService, mainFrame);
                } catch (InterruptedException | ExecutionException ex)
                {
                    Logger.getLogger(SaluhudDatabaseUpdater.class.getName()).log(Level.SEVERE, null, ex);
                    parseDatabaseUpdateFileLoadingDialog.dispose();
                }
            });

            parseDatabaseUpdateFileLoadingDialog.initialize();
        });
    }
}
