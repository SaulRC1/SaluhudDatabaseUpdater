package com.uhu.saluhud.saluhud.database.updater.ui.general.handler;

import com.uhu.saluhud.saluhud.database.updater.ui.general.InformationDialog;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class DisposeInformationDialogHandler implements InformationDialogHandler 
{
    private InformationDialog dialog;
    
    public DisposeInformationDialogHandler(InformationDialog dialog)
    {
        this.dialog = dialog;
    }

    @Override
    public void onOkPressed()
    {
        this.dialog.dispose();
    }
}
