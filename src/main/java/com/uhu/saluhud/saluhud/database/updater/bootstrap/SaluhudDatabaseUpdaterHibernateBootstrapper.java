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
        
        String dbUser = System.getenv("SALUHUD_DB_SUPER_USER");
        String dbPassword = System.getenv("SALUHUD_DB_SUPER_USER_PASSWORD");

        this.persistenceUnitProperties.put("jakarta.persistence.jdbc.user", dbUser);
        this.persistenceUnitProperties.put("jakarta.persistence.jdbc.password", dbPassword);
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
