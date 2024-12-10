package com.uhu.saluhud.saluhud.database.updater.bootstrap;

import com.mchange.v2.c3p0.ConnectionCustomizer;
import com.uhu.saluhud.saluhud.database.updater.ui.general.InformationDialog;
import com.uhu.saluhud.saluhud.database.updater.ui.general.handler.InformationDialogHandler;
import java.awt.Dimension;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.SwingUtilities;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseUpdaterConnectionCustomizer implements ConnectionCustomizer
{

    @Override
    public void onAcquire(Connection cnctn, String string) throws Exception
    {
        
    }

    @Override
    public void onDestroy(Connection cnctn, String string) throws Exception
    {
         SwingUtilities.invokeLater(() -> 
                {
                    InformationDialog connectionProblemDialog
                            = new InformationDialog(null, "Connection error", "A connection error has occurred while updating "
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

    @Override
    public void onCheckOut(Connection cnctn, String string) throws Exception
    {
        
    }

    @Override
    public void onCheckIn(Connection cnctn, String string) throws Exception
    {
        
    }

}
