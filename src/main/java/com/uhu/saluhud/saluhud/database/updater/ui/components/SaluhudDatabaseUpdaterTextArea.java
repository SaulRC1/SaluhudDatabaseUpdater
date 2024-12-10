package com.uhu.saluhud.saluhud.database.updater.ui.components;

import com.uhu.saluhud.saluhud.database.updater.data.DatabaseUpdateSQLStatement;
import com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageBuilder;
import com.uhu.saluhud.saluhud.database.updater.logging.DatabaseUpdateLogMessageStatus;
import com.uhu.saluhud.saluhud.database.updater.logging.SaluhudDatabaseUpdateLogger;
import com.uhu.saluhud.saluhud.database.updater.ui.SaluhudDatabaseUpdateMainJPanel;
import com.uhu.saluhud.saluhud.database.updater.ui.util.SaluhudLookAndFeelHelper;
import java.awt.Font;
import java.awt.FontFormatException;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseUpdaterTextArea extends JScrollPane implements SaluhudDatabaseUpdateLogger<DatabaseUpdateSQLStatement>
{

    private JTextArea loggingArea;
    private DatabaseUpdateLogMessageBuilder databaseUpdateLogMessageBuilder;
    
    public SaluhudDatabaseUpdaterTextArea()
    {
        super();
        
        this.databaseUpdateLogMessageBuilder = new DatabaseUpdateLogMessageBuilder();
        this.loggingArea = new JTextArea();
        
        try
        {
            InputStream fontStream = getClass().getClassLoader().getResourceAsStream("fonts/JetBrainsMono-Regular.ttf");
            Font jetBrainsMono = Font.createFont(Font.TRUETYPE_FONT, fontStream).deriveFont(12f);
            this.loggingArea.setFont(jetBrainsMono);
        } 
        catch (FontFormatException | IOException ex)
        {
            Logger.getLogger(SaluhudDatabaseUpdateMainJPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.loggingArea.setLineWrap(true);
        this.loggingArea.setWrapStyleWord(true);
        this.loggingArea.setEditable(false);
        
        this.setViewportView(this.loggingArea);
        this.getVerticalScrollBar().setUI(SaluhudLookAndFeelHelper.getSaluhudScrollBarUI());
    }

    @Override
    public void log(DatabaseUpdateSQLStatement message)
    {
        this.loggingArea.append(this.databaseUpdateLogMessageBuilder
                .buildLogMessageForSQLStatements(message, DatabaseUpdateLogMessageStatus.STANDARD) + "\n");
        
        this.loggingArea.setCaretPosition(this.loggingArea.getDocument().getLength());
    }

    @Override
    public void log(DatabaseUpdateSQLStatement message, DatabaseUpdateLogMessageStatus status)
    {
        this.loggingArea.append(this.databaseUpdateLogMessageBuilder.buildLogMessageForSQLStatements(message, status) + "\n");
        
        this.loggingArea.setCaretPosition(this.loggingArea.getDocument().getLength());
    }

    public JTextArea getLoggingArea()
    {
        return loggingArea;
    }

}
