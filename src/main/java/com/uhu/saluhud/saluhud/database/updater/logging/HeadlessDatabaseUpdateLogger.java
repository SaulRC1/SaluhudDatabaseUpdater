package com.uhu.saluhud.saluhud.database.updater.logging;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class HeadlessDatabaseUpdateLogger implements SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement>
{

    private Logger logger;
    private DatabaseUpdateLogMessageBuilder databaseUpdateLogMessageBuilder;

    public HeadlessDatabaseUpdateLogger(Logger logger)
    {
        this.logger = logger;
        this.databaseUpdateLogMessageBuilder = new DatabaseUpdateLogMessageBuilder();
    }
    
    @Override
    public void log(DatabaseUpdateSQLStatement message)
    {
        this.logger.log(Level.INFO, this.databaseUpdateLogMessageBuilder
                .buildLogMessageForSQLStatements(message, DatabaseUpdateLogMessageStatus.STANDARD));
    }

    @Override
    public void log(DatabaseUpdateSQLStatement message, DatabaseUpdateLogMessageStatus status)
    {
        switch(status)
        {
            case STANDARD:
            case SUCCESS:
                this.logger.log(Level.INFO, this.databaseUpdateLogMessageBuilder.buildLogMessageForSQLStatements(message, status));
                break;
            case FAILED:
                this.logger.log(Level.SEVERE, this.databaseUpdateLogMessageBuilder.buildLogMessageForSQLStatements(message, status));
                break;
        }
    }

}
