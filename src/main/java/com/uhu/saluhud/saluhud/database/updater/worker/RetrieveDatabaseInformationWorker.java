package com.uhu.saluhud.saluhud.database.updater.worker;

import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.service.SaluhudSystemService;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.swing.SwingWorker;
import org.hibernate.exception.SQLGrammarException;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class RetrieveDatabaseInformationWorker extends SwingWorker<SaluhudDatabaseInformation, Void>
{

    @Override
    protected SaluhudDatabaseInformation doInBackground() throws Exception
    {
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
        
        return saluhudDatabaseInformation;
    }

}
