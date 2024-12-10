package com.uhu.saluhud.saluhud.database.updater.worker;

import com.uhu.saluhud.saluhud.database.updater.bootstrap.SaluhudDatabaseUpdaterHibernateBootstrapper;
import jakarta.persistence.EntityManagerFactory;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.SwingWorker;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class InitializeDatabaseConnectionWorker extends SwingWorker<EntityManagerFactory, Void>
{

    private final SaluhudDatabaseUpdaterHibernateBootstrapper hibernateBootstrapper;

    public InitializeDatabaseConnectionWorker(SaluhudDatabaseUpdaterHibernateBootstrapper hibernateBootstrapper)
    {
        this.hibernateBootstrapper = hibernateBootstrapper;
    }
    
    @Override
    protected EntityManagerFactory doInBackground() throws Exception
    {
        EntityManagerFactory entityManagerFactory;

        this.hibernateBootstrapper.initializeJpa();
            
        entityManagerFactory = this.hibernateBootstrapper.getEntityManagerFactory();

        return entityManagerFactory;
    }
    
}
