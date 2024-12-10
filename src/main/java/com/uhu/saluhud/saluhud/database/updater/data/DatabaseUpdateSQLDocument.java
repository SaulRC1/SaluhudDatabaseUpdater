package com.uhu.saluhud.saluhud.database.updater.data;

import java.util.ArrayList;
import java.util.List;

/**
 * In-memory representation of the database update SQL file.
 * 
 * @author Saúl Rodríguez Naranjo
 */
public class DatabaseUpdateSQLDocument 
{
    private List<DatabaseUpdateSQLStatement> statements;
    
    public DatabaseUpdateSQLDocument()
    {
        statements = new ArrayList<>();
    }
    
    public void addSQLStatement(DatabaseUpdateSQLStatement sqlStatement)
    {
        if(sqlStatement != null)
        {
            this.statements.add(sqlStatement);
        }
    }
    
    public List<DatabaseUpdateSQLStatement> getSQLStatements()
    {
        return this.statements;
    }
}
