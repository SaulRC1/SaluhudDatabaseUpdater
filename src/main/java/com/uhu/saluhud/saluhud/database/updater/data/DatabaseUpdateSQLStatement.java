package com.uhu.saluhud.saluhud.database.updater.data;

import java.time.LocalDate;

/**
 * Represents a SQL statement from the database update document.
 * 
 * @author Saúl Rodríguez Naranjo
 */
public class DatabaseUpdateSQLStatement 
{
    private LocalDate statementInsertionDate;
    private String statement;

    public DatabaseUpdateSQLStatement()
    {
    }

    public DatabaseUpdateSQLStatement(LocalDate statementInsertionDate, String statement)
    {
        this.statementInsertionDate = statementInsertionDate;
        this.statement = statement;
    }

    public LocalDate getStatementInsertionDate()
    {
        return statementInsertionDate;
    }

    public void setStatementInsertionDate(LocalDate statementInsertionDate)
    {
        this.statementInsertionDate = statementInsertionDate;
    }

    public String getStatement()
    {
        return statement;
    }

    public void setStatement(String statement)
    {
        this.statement = statement;
    }
    
    
}
