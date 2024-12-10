package com.uhu.saluhud.saluhud.database.updater.bootstrap;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseUpdaterHibernateBootstrapper 
{

    private final String persistenceUnitName;
    private final Map persistenceUnitProperties;
    
    private EntityManagerFactory entityManagerFactory;

    public SaluhudDatabaseUpdaterHibernateBootstrapper(String persistenceUnitName)
    {
        this.persistenceUnitName = persistenceUnitName;
        this.persistenceUnitProperties = new HashMap();
    }

    public SaluhudDatabaseUpdaterHibernateBootstrapper(String persistenceUnitName, Map persistenceUnitProperties)
    {
        this.persistenceUnitName = persistenceUnitName;
        this.persistenceUnitProperties = persistenceUnitProperties;
    }
    
    public void initializeJpa()
    {
        entityManagerFactory = Persistence.createEntityManagerFactory(persistenceUnitName, persistenceUnitProperties);
    }

    public EntityManagerFactory getEntityManagerFactory()
    {
        return entityManagerFactory;
    }

    public String getPersistenceUnitName()
    {
        return persistenceUnitName;
    }

    public Map getPersistenceUnitProperties()
    {
        return persistenceUnitProperties;
    }
    
}
