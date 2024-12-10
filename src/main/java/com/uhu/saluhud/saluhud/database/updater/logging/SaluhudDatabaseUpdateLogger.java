package com.uhu.saluhud.saluhud.database.updater.logging;

/**
 * An interface that must be implemented by al classes that may act as a logger
 * for database update messages.
 * 
 * @author SaulRC1
 * @param <T>
 */
public interface SaluhudDatabaseUpdateLogger<T>
{
    public void log(T message);
    
    public void log(T message, DatabaseUpdateLogMessageStatus status);
}
