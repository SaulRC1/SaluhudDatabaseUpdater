package com.uhu.saluhud.saluhud.database.updater.parser;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLDocument;
import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * {@link SaluhudDatabaseUpdateFileParser} for SQL database update file.
 * 
 * @author Saúl Rodríguez Naranjo
 */
public class DatabaseUpdateSQLFileParser implements SaluhudDatabaseUpdateFileParser<DatabaseUpdateSQLDocument>
{

    @Override
    public DatabaseUpdateSQLDocument parseFile(File file) throws IOException
    {
        DatabaseUpdateSQLDocument databaseUpdateSQLDocument = new DatabaseUpdateSQLDocument();
        
        try(BufferedReader bufferedReader = new BufferedReader(new FileReader(file, StandardCharsets.UTF_8)))
        {
            DatabaseUpdateSQLStatement dbUpdateSqlStatement;
            LocalDate statementInsertionDate = null;
            String sqlStatement = "";
            
            String line;
            
            while((line = bufferedReader.readLine()) != null)
            {
                if(line.startsWith("-- START SQL STATEMENTS DATE -->"))
                {
                    statementInsertionDate = parseStatementInsertionDate(line);
                }
                
                //Ignore SQL comments
                if(!line.startsWith("--"))
                {
                    sqlStatement += line;
                }
                
                if(!line.startsWith("--") && line.endsWith(";"))
                {
                    dbUpdateSqlStatement = new DatabaseUpdateSQLStatement(statementInsertionDate, sqlStatement);
                    databaseUpdateSQLDocument.addSQLStatement(dbUpdateSqlStatement);
                    
                    //Reset sql statement
                    sqlStatement = "";
                }
            }
        }
        
        return databaseUpdateSQLDocument;
    }

    @Override
    public DatabaseUpdateSQLDocument parseFile(String filePath) throws IOException
    {
        File databaseUpdateFile = new File(filePath);
        
        return parseFile(databaseUpdateFile);
    }
    
    private LocalDate parseStatementInsertionDate(String documentLine)
    {
        String[] split = documentLine.split("-- START SQL STATEMENTS DATE -->");
        
        String insertionDateString = split[1].trim();
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        
        return LocalDate.parse(insertionDateString, formatter);
    }

    @Override
    public DatabaseUpdateSQLDocument parseFile(InputStream inputStream) throws IOException
    {
        DatabaseUpdateSQLDocument databaseUpdateSQLDocument = new DatabaseUpdateSQLDocument();
        
        try(BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8)))
        {
            DatabaseUpdateSQLStatement dbUpdateSqlStatement;
            LocalDate statementInsertionDate = null;
            String sqlStatement = "";
            
            String line;
            
            while((line = bufferedReader.readLine()) != null)
            {
                if(line.startsWith("-- START SQL STATEMENTS DATE -->"))
                {
                    statementInsertionDate = parseStatementInsertionDate(line);
                }
                
                //Ignore SQL comments
                if(!line.startsWith("--"))
                {
                    sqlStatement += line;
                }
                
                if(!line.startsWith("--") && line.endsWith(";"))
                {
                    dbUpdateSqlStatement = new DatabaseUpdateSQLStatement(statementInsertionDate, sqlStatement);
                    databaseUpdateSQLDocument.addSQLStatement(dbUpdateSqlStatement);
                    
                    //Reset sql statement
                    sqlStatement = "";
                }
            }
        }
        
        return databaseUpdateSQLDocument;
    }

}
