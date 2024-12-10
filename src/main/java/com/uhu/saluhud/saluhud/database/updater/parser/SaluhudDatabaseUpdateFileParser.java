package com.uhu.saluhud.saluhud.database.updater.parser;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Database update file parser. General interface to be implemented by all classes
 * whose purpose is to read a Saluhud's database update file of any type and convert
 * it to a feasible and interpretrable object that can be treated by Saluhud Database 
 * Updater program.
 * 
 * @author Saúl Rodríguez Naranjo
 * @param <T> The desired returned object from the file parsing.
 */
public interface SaluhudDatabaseUpdateFileParser<T>
{
    public T parseFile(File file) throws IOException;
    
    public T parseFile(String filePath) throws IOException;
    
    public T parseFile(InputStream inputStream) throws IOException;
}
