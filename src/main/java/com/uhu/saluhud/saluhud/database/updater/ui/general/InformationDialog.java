package com.uhu.saluhud.saluhud.database.updater.ui.general;

import com.uhu.saluhud.saluhud.database.updater.ui.SaluhudDatabaseUpdateMainJPanel;
import com.uhu.saluhud.saluhud.database.updater.ui.components.SaluhudButton;
import com.uhu.saluhud.saluhud.database.updater.ui.general.handler.InformationDialogHandler;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.Frame;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class InformationDialog extends JDialog
{
    private String informationMessage;
    private JLabel informationMessageLabel;
    private SaluhudButton okButton;
    
    private InformationDialogHandler informationDialogHandler;
    
    public InformationDialog(Frame owner, String title, String informationMessage, 
            Dimension size, InformationDialogHandler informationDialogHandler)
    {
        super(owner, title, true);
        this.setMinimumSize(size);
        this.setSize(size);
        this.setResizable(false);
        this.informationMessage = informationMessage;
        this.informationMessageLabel = new JLabel();
        this.okButton = new SaluhudButton("Ok");
        this.informationDialogHandler = informationDialogHandler;
    }
    
    public InformationDialog(Frame owner, String title, String informationMessage, 
            Dimension size)
    {
        super(owner, title, true);
        this.setMinimumSize(size);
        this.setSize(size);
        this.setResizable(false);
        this.informationMessage = informationMessage;
        this.informationMessageLabel = new JLabel();
        this.okButton = new SaluhudButton("Ok");
    }
    
    public void initialize()
    {
        this.getContentPane().setBackground(Color.WHITE);
        this.setLayout(new BoxLayout(this.getContentPane(), BoxLayout.Y_AXIS));
        
        try
        {
            InputStream fontStream = getClass().getClassLoader().getResourceAsStream("fonts/JetBrainsMono-Regular.ttf");
            Font jetBrainsMono = Font.createFont(Font.TRUETYPE_FONT, fontStream).deriveFont(14f);
            informationMessageLabel.setFont(jetBrainsMono);
        } catch (FontFormatException | IOException ex)
        {
            Logger.getLogger(InformationDialog.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.informationMessageLabel.setText("<html><p>" + informationMessage + "<html><p>");
        this.informationMessageLabel.setPreferredSize(new Dimension(this.getWidth(), (this.getHeight()) - 30));
        this.informationMessageLabel.setMaximumSize(new Dimension(this.getWidth(), (this.getHeight()) - 30));
        this.informationMessageLabel.setAlignmentX(CENTER_ALIGNMENT);
        informationMessageLabel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        JPanel okButtonPanel = new JPanel(new BorderLayout());
        okButtonPanel.setPreferredSize(new Dimension(100, 30));
        okButtonPanel.setMaximumSize(new Dimension(100, 30));
        okButtonPanel.setBackground(Color.WHITE);
        okButtonPanel.setBorder(BorderFactory.createEmptyBorder(0, 10, 10, 10));
        okButtonPanel.setAlignmentX(CENTER_ALIGNMENT);
        
        okButtonPanel.add(this.okButton, BorderLayout.CENTER);
        
        this.okButton.addMouseListener(new MouseAdapter() 
        {
            @Override
            public void mouseClicked(MouseEvent e)
            {
                if(informationDialogHandler != null)
                {
                    informationDialogHandler.onOkPressed();
                }
            }
        });

        this.add(informationMessageLabel);
        this.add(okButtonPanel);
        
        this.pack();
        this.setLocationRelativeTo(getOwner());
        this.setVisible(true);
    }

    public void setInformationDialogHandler(InformationDialogHandler informationDialogHandler)
    {
        this.informationDialogHandler = informationDialogHandler;
    }

}
