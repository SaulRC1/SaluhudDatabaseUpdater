package com.uhu.saluhud.saluhud.database.updater.ui;

import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseExecutorService;
import com.uhu.saluhud.saluhud.database.updater.data.SaluhudDatabaseInformation;
import com.uhu.saluhud.saluhud.database.updater.ui.components.SaluhudDatabaseUpdaterTextArea;
import com.uhu.saluhud.saluhud.database.updater.ui.util.ImageUtils;
import com.uhu.saluhud.saluhud.database.updater.ui.util.SaluhudLookAndFeelHelper;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Image;
import java.awt.Insets;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.SwingUtilities;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseUpdateMainJPanel extends JPanel
{
    private JProgressBar databaseUpdateJProgressBar;
    private JPanel databaseUpdateImageJPanel;
    private DatabaseInformationJPanel databaseUpdateInformationJPanel;
    private SaluhudDatabaseUpdaterTextArea saluhudDatabaseUpdaterTextArea;
    private JFrame owner;
    
    public SaluhudDatabaseUpdateMainJPanel(JFrame owner)
    {
        super(new GridBagLayout());
        this.databaseUpdateJProgressBar = new JProgressBar();
        this.databaseUpdateJProgressBar.setStringPainted(true);
        this.databaseUpdateJProgressBar.setString("");
        this.databaseUpdateJProgressBar.setForeground(SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR);
        this.databaseUpdateImageJPanel = new JPanel();
        this.saluhudDatabaseUpdaterTextArea = new SaluhudDatabaseUpdaterTextArea();
        this.databaseUpdateInformationJPanel = new DatabaseInformationJPanel(owner, databaseUpdateJProgressBar, 
                saluhudDatabaseUpdaterTextArea);
        this.owner = owner;
    }
    
    public void initialize()
    {
        GridBagConstraints databaseUpdateImageJPanelGridBagConstraints = new GridBagConstraints();
        databaseUpdateImageJPanelGridBagConstraints.gridx = 0;
        databaseUpdateImageJPanelGridBagConstraints.gridy = 0;
        databaseUpdateImageJPanelGridBagConstraints.weightx = 0.5;
        databaseUpdateImageJPanelGridBagConstraints.weighty = 0.5;
        databaseUpdateImageJPanelGridBagConstraints.fill = GridBagConstraints.BOTH;
        
        initializeDatabaseUpdateImageJPanel();
        
        GridBagConstraints databaseUpdateInformationJPanelGridBagConstraints = new GridBagConstraints();
        databaseUpdateInformationJPanelGridBagConstraints.gridx = 1;
        databaseUpdateInformationJPanelGridBagConstraints.gridy = 0;
        databaseUpdateInformationJPanelGridBagConstraints.weightx = 0.5;
        databaseUpdateInformationJPanelGridBagConstraints.weighty = 1.0;
        databaseUpdateInformationJPanelGridBagConstraints.fill = GridBagConstraints.BOTH;
        
        initializeDatabaseUpdateInformationJPanel();
        
        GridBagConstraints databaseUpdateLogsTextAreaGridBagConstraints = new GridBagConstraints();
        databaseUpdateLogsTextAreaGridBagConstraints.gridwidth = 2;
        databaseUpdateLogsTextAreaGridBagConstraints.gridx = 0;
        databaseUpdateLogsTextAreaGridBagConstraints.gridy = 1;
        databaseUpdateLogsTextAreaGridBagConstraints.weightx = 1.0;
        databaseUpdateLogsTextAreaGridBagConstraints.weighty = 1.0;
        databaseUpdateLogsTextAreaGridBagConstraints.fill = GridBagConstraints.BOTH;
        databaseUpdateLogsTextAreaGridBagConstraints.insets = new Insets(10, 10, 10, 10);
        
        this.saluhudDatabaseUpdaterTextArea.setPreferredSize(new Dimension(600, 250));
        this.saluhudDatabaseUpdaterTextArea.setMinimumSize(new Dimension(600, 250));
        
        SaluhudDatabaseInformation.registerSaluhudDatabaseUpdateLogger(saluhudDatabaseUpdaterTextArea);
        
        GridBagConstraints databaseUpdateJProgressBarGridBagConstraints = new GridBagConstraints();
        databaseUpdateJProgressBarGridBagConstraints.gridwidth = 2;
        databaseUpdateJProgressBarGridBagConstraints.gridx = 0;
        databaseUpdateJProgressBarGridBagConstraints.gridy = 2;
        databaseUpdateJProgressBarGridBagConstraints.weightx = 1.0;
        databaseUpdateJProgressBarGridBagConstraints.fill = GridBagConstraints.HORIZONTAL;
        databaseUpdateJProgressBarGridBagConstraints.insets = new Insets(0, 10, 20, 10);
        
        initializeDatabaseUpdateJProgressBar();
        
        this.add(databaseUpdateImageJPanel, databaseUpdateImageJPanelGridBagConstraints);
        this.add(databaseUpdateInformationJPanel, databaseUpdateInformationJPanelGridBagConstraints);
        this.add(saluhudDatabaseUpdaterTextArea, databaseUpdateLogsTextAreaGridBagConstraints);
        this.add(databaseUpdateJProgressBar, databaseUpdateJProgressBarGridBagConstraints);

        this.setBackground(Color.WHITE);
    }
    
    public void initializeDatabaseUpdateImageJPanel()
    {
        this.databaseUpdateImageJPanel.setBackground(Color.WHITE);
        
        this.databaseUpdateImageJPanel.setPreferredSize(new Dimension(400, 100));
        this.databaseUpdateImageJPanel.setMinimumSize(new Dimension(400, 100));
        
        //System.out.println("App path: " + new File("").getAbsolutePath());
        
        try
        {
            InputStream imageInputStream = getClass().getClassLoader().getResourceAsStream("images/Saluhud_logo512x512.png");
            BufferedImage image = ImageIO.read(imageInputStream);
            
            Image scaledImage = ImageUtils.scaleImageWithinBoundaries(image, new Dimension(400, 150), true);
            
            databaseUpdateImageJPanel.setLayout(new BorderLayout());
            
            JLabel imageLabel = new JLabel(new ImageIcon(scaledImage));
            imageLabel.setBackground(Color.white);
            
            databaseUpdateImageJPanel.add(imageLabel, BorderLayout.CENTER);
            
            this.databaseUpdateImageJPanel.addComponentListener(new ComponentAdapter()
            {
                @Override
                public void componentResized(ComponentEvent e)
                {
                    SaluhudDatabaseExecutorService.executorService.submit(() -> 
                    {
                        Image scaledImage = ImageUtils.scaleImageWithinBoundaries(image, 
                            new Dimension(databaseUpdateImageJPanel.getWidth(), 
                                    databaseUpdateImageJPanel.getHeight()), true);
                        
                        ImageIcon scaledImageIcon = new ImageIcon(scaledImage);
                        
                        SwingUtilities.invokeLater(() -> 
                        {
                            imageLabel.setIcon(scaledImageIcon);
                            databaseUpdateImageJPanel.repaint();
                        });
                    });
                }
                
            });
            
        } catch (IOException ex)
        {
            Logger.getLogger(SaluhudDatabaseUpdateMainJPanel.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
        }
    }
    
    public void initializeDatabaseUpdateInformationJPanel()
    {
        this.databaseUpdateInformationJPanel.setMinimumSize(new Dimension(400, 150));
        this.databaseUpdateInformationJPanel.setPreferredSize(new Dimension(400, 150));
        
        this.databaseUpdateInformationJPanel.initialize();
    }
    
    public void initializeDatabaseUpdateJProgressBar()
    {
        this.databaseUpdateJProgressBar.setMinimumSize(new Dimension(400, 30));
        this.databaseUpdateJProgressBar.setPreferredSize(new Dimension(400, 30));
    }

    public JProgressBar getDatabaseUpdateJProgressBar()
    {
        return databaseUpdateJProgressBar;
    }

    public JPanel getDatabaseUpdateImageJPanel()
    {
        return databaseUpdateImageJPanel;
    }

    public DatabaseInformationJPanel getDatabaseUpdateInformationJPanel()
    {
        return databaseUpdateInformationJPanel;
    }
}
