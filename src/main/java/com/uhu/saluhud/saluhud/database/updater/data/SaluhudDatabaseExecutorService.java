package com.uhu.saluhud.saluhud.database.updater.data;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseExecutorService 
{
    public static final ExecutorService executorService = Executors.newSingleThreadExecutor();
}
