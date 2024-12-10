package com.uhu.saluhud.saluhud.database.updater.ui.general;

import com.uhu.saluhud.saluhud.database.updater.ui.SaluhudDatabaseUpdateMainJPanel;
import com.uhu.saluhud.saluhud.database.updater.ui.util.ImageUtils;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.Frame;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class LoadingDialog extends JDialog
{

    private String loadingText;
    private JLabel loadingTextLabel;

    public LoadingDialog(Frame owner, String title, String loadingText)
    {
        super(owner, title, true);
        this.loadingText = loadingText;
        this.loadingTextLabel = new JLabel();
    }

    public void initialize()
    {
        this.getContentPane().setBackground(Color.WHITE);
        this.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
        
        try
        {
            InputStream fontStream = getClass().getClassLoader().getResourceAsStream("fonts/JetBrainsMono-Regular.ttf");
            Font jetBrainsMono = Font.createFont(Font.TRUETYPE_FONT, fontStream).deriveFont(14f);
            loadingTextLabel.setFont(jetBrainsMono);
        } catch (FontFormatException | IOException ex)
        {
            Logger.getLogger(LoadingDialog.class.getName()).log(Level.SEVERE, null, ex);
        }

        loadingTextLabel.setText(loadingText);
        loadingTextLabel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        JLabel imageLabel = new JLabel(new ImageIcon(getClass().getResource("/images/Dual-Ring-75px-75px.gif")));
        imageLabel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        this.setLayout(new BorderLayout());

        this.add(imageLabel, BorderLayout.CENTER);
        this.add(loadingTextLabel, BorderLayout.NORTH);

        this.pack();
        this.setLocationRelativeTo(getOwner());
        this.setVisible(true);
    }

}
