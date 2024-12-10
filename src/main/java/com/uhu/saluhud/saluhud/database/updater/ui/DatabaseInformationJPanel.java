package com.uhu.saluhud.saluhud.database.updater.ui;

import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseExecutorService;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.ui.components.SaluhudButton;
import com.uhu.saluhud.saluhud.database.updater.ui.components.SaluhudDatabaseUpdaterTextArea;
import com.uhu.saluhud.saluhud.database.updater.worker.UpdateDatabaseWorker;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.IOException;
import java.io.InputStream;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.ExecutionException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import org.hibernate.exception.JDBCConnectionException;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class DatabaseInformationJPanel extends JPanel
{

    private JLabel databaseCurrentVersionLabel;
    private JLabel databaseLastVersionDateLabel;
    private JLabel databaseVersionAfterUpdateLabel;
    private JLabel databaseNewVersionDateLabel;
    private JLabel databaseUpdaterVersionLabel;
    private SaluhudButton startDatabaseUpdateButton;
    
    private JPanel informationContainerPanel;
    private JPanel informationPanel;
    private JPanel informationValuesPanel;
    private JFrame owner;
    private JProgressBar progressBar;
    private SaluhudDatabaseUpdaterTextArea saluhudDatabaseUpdaterTextArea;

    public DatabaseInformationJPanel(JFrame owner, JProgressBar progressBar,
            SaluhudDatabaseUpdaterTextArea saluhudDatabaseUpdaterTextArea)
    {
        super(new GridLayout(2, 1));
        this.setBackground(Color.WHITE);
        informationContainerPanel = new JPanel(new GridBagLayout());
        informationContainerPanel.setBackground(Color.WHITE);
        informationPanel = new JPanel(new GridLayout(5, 1));
        informationPanel.setBackground(Color.WHITE);
        informationValuesPanel = new JPanel(new GridLayout(5, 1));
        informationValuesPanel.setBackground(Color.WHITE);
        databaseCurrentVersionLabel = new JLabel();
        databaseLastVersionDateLabel = new JLabel();
        databaseVersionAfterUpdateLabel = new JLabel();
        databaseNewVersionDateLabel = new JLabel();
        databaseUpdaterVersionLabel = new JLabel();
        startDatabaseUpdateButton = new SaluhudButton("Update database");
        this.owner = owner;
        this.progressBar = progressBar;
        this.saluhudDatabaseUpdaterTextArea = saluhudDatabaseUpdaterTextArea;
    }

    public void initialize()
    {
        try
        {
            InputStream fontStream = getClass().getClassLoader().getResourceAsStream("fonts/JetBrainsMono-Regular.ttf");
            Font jetBrainsMono = Font.createFont(Font.TRUETYPE_FONT, fontStream).deriveFont(12f);
            databaseCurrentVersionLabel.setFont(jetBrainsMono);
            databaseLastVersionDateLabel.setFont(jetBrainsMono);
            databaseVersionAfterUpdateLabel.setFont(jetBrainsMono);
            databaseNewVersionDateLabel.setFont(jetBrainsMono);
            databaseUpdaterVersionLabel.setFont(jetBrainsMono);
        } 
        catch (FontFormatException | IOException ex)
        {
            Logger.getLogger(SaluhudDatabaseUpdateMainJPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        databaseCurrentVersionLabel.setText("Database current version:");
        databaseLastVersionDateLabel.setText("Database last version date:");
        databaseVersionAfterUpdateLabel.setText("Database version after update:");
        databaseNewVersionDateLabel.setText("Database new version date:");
        databaseUpdaterVersionLabel.setText("Database updater version:");
        
        this.informationPanel.add(databaseCurrentVersionLabel);
        this.informationPanel.add(databaseLastVersionDateLabel);
        this.informationPanel.add(databaseVersionAfterUpdateLabel);
        this.informationPanel.add(databaseNewVersionDateLabel);
        this.informationPanel.add(databaseUpdaterVersionLabel);
        
        JPanel startDatabaseUpdateButtonJPanel = new JPanel(new BorderLayout());
        startDatabaseUpdateButtonJPanel.setBackground(Color.WHITE);
        
        this.startDatabaseUpdateButton.addMouseListener(new MouseAdapter() 
        {
            @Override
            public void mouseClicked(MouseEvent e)
            {
                if(!startDatabaseUpdateButton.isEnabled())
                {
                    return;
                }
                
                saluhudDatabaseUpdaterTextArea.getLoggingArea().setText("");
                startDatabaseUpdateButton.setEnabled(false);
                
                owner.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                
                UpdateDatabaseWorker updateDatabaseWorker 
                        = new UpdateDatabaseWorker(SaluhudDatabaseInformation.databaseUpdateSQLDocument, 
                                SaluhudDatabaseInformation.databaseUpdateLoggers, owner, startDatabaseUpdateButton);
                
                updateDatabaseWorker.addPropertyChangeListener((PropertyChangeEvent evt) ->
                {
                    if ("progress".equals(evt.getPropertyName()))
                    {
                        Integer progressValue = (Integer) evt.getNewValue();
                        progressBar.setValue(progressValue);
                        progressBar.setString("Updating database..." + progressValue.toString() + "%");
                    }
                });
                
                SaluhudDatabaseExecutorService.executorService.submit(() ->
                {
                    updateDatabaseWorker.execute();
                });
            }
        });
        
        startDatabaseUpdateButtonJPanel.add(this.startDatabaseUpdateButton);
        startDatabaseUpdateButtonJPanel.setBorder(BorderFactory.createEmptyBorder(20, 10, 20, 10));
        
        //this.informationPanel.setBackground(Color.red);
        //this.informationValuesPanel.setBackground(Color.blue);
        
        this.informationContainerPanel.add(this.informationPanel, createGridBagConstraints(0, 0, 1.5, 1));
        this.informationContainerPanel.add(this.informationValuesPanel, createGridBagConstraints(1, 0, 1, 1));
        
        this.add(informationContainerPanel);
        this.add(startDatabaseUpdateButtonJPanel);
    }
    
    public void loadSaluhudDatabaseInformation(SaluhudDatabaseInformation saluhudDatabaseInformation)
    {
        JLabel databaseCurrentVersionValueLabel = new JLabel(saluhudDatabaseInformation.getDatabaseCurrentVersion());
        JLabel databaseLastVersionDateValueLabel = new JLabel(saluhudDatabaseInformation.getDatabaseLastVersionDate());
        JLabel databaseVersionAfterUpdateValueLabel = new JLabel(saluhudDatabaseInformation.getDatabaseVersionAfterUpdate());
        JLabel databaseNewVersionDateValueLabel = new JLabel(saluhudDatabaseInformation.getDatabaseNewVersionDate());
        JLabel databaseUpdaterVersionValueLabel = new JLabel(saluhudDatabaseInformation.getSaluhudDatabaseUpdaterVersion());
        
        this.informationValuesPanel.add(databaseCurrentVersionValueLabel);
        this.informationValuesPanel.add(databaseLastVersionDateValueLabel);
        this.informationValuesPanel.add(databaseVersionAfterUpdateValueLabel);
        this.informationValuesPanel.add(databaseNewVersionDateValueLabel);
        this.informationValuesPanel.add(databaseUpdaterVersionValueLabel);
    }
    
    private GridBagConstraints createGridBagConstraints(int x, int y, double weightX, double weightY) {
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = x;
        gbc.gridy = y;
        gbc.weightx = weightX;
        gbc.weighty = weightY;
        gbc.fill = GridBagConstraints.HORIZONTAL;
        int gap = 3;
        gbc.insets = new Insets(gap, gap + 2 * gap * x, gap, gap);
        return gbc;
    }
}
