package com.uhu.saluhud.saluhud.database.updater.logging;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import static com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus.FAILED;
import static com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus.STANDARD;
import static com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus.SUCCESS;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class DatabaseUpdateLogMessageBuilder 
{
    private DateTimeFormatter dateTimeFormatter;
    
    public DatabaseUpdateLogMessageBuilder()
    {
        this.dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MMM/yyyy HH:mm:ss");
    }

    public DatabaseUpdateLogMessageBuilder(DateTimeFormatter dateTimeFormatter)
    {
        this.dateTimeFormatter = dateTimeFormatter;
    }
    
    public String buildLogMessageForSQLStatements(DatabaseUpdateSQLStatement statement, DatabaseUpdateLogMessageStatus status)
    {
        StringBuilder stringBuilder = new StringBuilder();
        DateTimeFormatter sqlStatementInsertionDateFormatter = DateTimeFormatter.ofPattern("dd/MMM/yyyy");
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        stringBuilder.append("[").append(this.dateTimeFormatter.format(currentDateTime))
                .append("]");
        
        switch (status)
        {
            case STANDARD:
                stringBuilder.append(" - ");
                break;
            case FAILED:
                stringBuilder.append(" << FAILED >> ");
                break;
            case SUCCESS:
                stringBuilder.append(" << SUCCESS >> ");
                break;
            default:
                throw new AssertionError();
        }       
        
        stringBuilder.append("Executing statement with insertion date (")
                .append(sqlStatementInsertionDateFormatter.format(statement.getStatementInsertionDate()))
                .append("): ").append("\"").append(statement.getStatement()).append("\"");
        
        return stringBuilder.toString();
    }

    public void setDateTimeFormatter(DateTimeFormatter dateTimeFormatter)
    {
        this.dateTimeFormatter = dateTimeFormatter;
    }
}
