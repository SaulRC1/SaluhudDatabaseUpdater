package com.uhu.saluhud.saluhud.database.updater.data;

import com.uhu.saluhud.saluhud.database.updater.logging.SaluhudDatabaseUpdateLogger;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseInformation 
{
    public static EntityManagerFactory emf;
    public static EntityManager em;
    public static DatabaseUpdateSQLDocument databaseUpdateSQLDocument;
    public static List<SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement>> databaseUpdateLoggers = new ArrayList<>();
    
    private String databaseCurrentVersion;
    private String databaseLastVersionDate;
    private String databaseVersionAfterUpdate;
    private String databaseNewVersionDate;
    private String saluhudDatabaseUpdaterVersion;

    public SaluhudDatabaseInformation(String databaseCurrentVersion, String databaseLastVersionDate, 
            String databaseVersionAfterUpdate, String databaseNewVersionDate, String saluhudDatabaseUpdaterVersion)
    {
        this.databaseCurrentVersion = databaseCurrentVersion;
        this.databaseLastVersionDate = databaseLastVersionDate;
        this.databaseVersionAfterUpdate = databaseVersionAfterUpdate;
        this.databaseNewVersionDate = databaseNewVersionDate;
        this.saluhudDatabaseUpdaterVersion = saluhudDatabaseUpdaterVersion;
    }

    public String getDatabaseCurrentVersion()
    {
        return databaseCurrentVersion;
    }

    public String getDatabaseLastVersionDate()
    {
        return databaseLastVersionDate;
    }

    public String getDatabaseVersionAfterUpdate()
    {
        return databaseVersionAfterUpdate;
    }

    public String getDatabaseNewVersionDate()
    {
        return databaseNewVersionDate;
    }

    public String getSaluhudDatabaseUpdaterVersion()
    {
        return saluhudDatabaseUpdaterVersion;
    }

    public void setDatabaseCurrentVersion(String databaseCurrentVersion)
    {
        this.databaseCurrentVersion = databaseCurrentVersion;
    }

    public void setDatabaseLastVersionDate(String databaseLastVersionDate)
    {
        this.databaseLastVersionDate = databaseLastVersionDate;
    }

    public void setDatabaseVersionAfterUpdate(String databaseVersionAfterUpdate)
    {
        this.databaseVersionAfterUpdate = databaseVersionAfterUpdate;
    }

    public void setDatabaseNewVersionDate(String databaseNewVersionDate)
    {
        this.databaseNewVersionDate = databaseNewVersionDate;
    }

    public void setSaluhudDatabaseUpdaterVersion(String saluhudDatabaseUpdaterVersion)
    {
        this.saluhudDatabaseUpdaterVersion = saluhudDatabaseUpdaterVersion;
    }
    
    public static void registerSaluhudDatabaseUpdateLogger(SaluhudDatabaseUpdateLogger logger)
    {
        databaseUpdateLoggers.add(logger);
    }

    @Override
    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("SaluhudDatabaseInformation{");
        sb.append("databaseCurrentVersion=").append(databaseCurrentVersion);
        sb.append(", databaseLastVersionDate=").append(databaseLastVersionDate);
        sb.append(", databaseVersionAfterUpdate=").append(databaseVersionAfterUpdate);
        sb.append(", databaseNewVersionDate=").append(databaseNewVersionDate);
        sb.append(", saluhudDatabaseUpdaterVersion=").append(saluhudDatabaseUpdaterVersion);
        sb.append('}');
        return sb.toString();
    }
}
