package com.uhu.saluhud.saluhud.database.updater.worker;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.parser.DatabaseUpdateSQLFileParser;
import com.uhu.saluhud.saluhud.database.updater.parser.SaluhudDatabaseUpdateFileParser;
import java.io.File;
import java.io.InputStream;
import javax.swing.SwingWorker;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class ParseDatabaseUpdateFileWorker extends SwingWorker<DatabaseUpdateSQLDocument, Void>
{

    @Override
    protected DatabaseUpdateSQLDocument doInBackground() throws Exception
    {
        SaluhudDatabaseUpdateFileParser<DatabaseUpdateSQLDocument> fileParser 
                = new DatabaseUpdateSQLFileParser();
        
        InputStream databaseUpdateFileInputStream = 
                Thread.currentThread().getContextClassLoader().getResourceAsStream("database/database_update.sql");
        
        return fileParser.parseFile(databaseUpdateFileInputStream);
    }

}
