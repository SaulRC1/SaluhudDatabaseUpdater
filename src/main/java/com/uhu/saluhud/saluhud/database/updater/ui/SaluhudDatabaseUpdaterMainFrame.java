package com.uhu.saluhud.saluhud.database.updater.ui;

import com.uhu.saluhud.saluhud.database.updater.ui.util.ImageUtils;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GraphicsEnvironment;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 * Main {@link JFrame} for the SaluhudDatabaseUpdater
 * 
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudDatabaseUpdaterMainFrame extends JFrame
{
    private final int minWidth;
    private final int minHeight;
    private int width;
    private int height;
    
    private final String frameTitle;
    
    private final GraphicsEnvironment graphicsEnvironment;
    private final Toolkit awtToolkit;
    
    private SaluhudDatabaseUpdateMainJPanel saluhudDatabaseUpdateMainJPanel;

    /**
     * Builds a {@link SaluhudDatabaseUpdaterMainFrame} with the desired minimum
     * width/height, the actual width/height and title.
     * 
     * @param minWidth Minimum frame width
     * @param minHeight Minimum frame height
     * @param width Frame width
     * @param height Frame height
     * @param frameTitle Frame title
     */
    public SaluhudDatabaseUpdaterMainFrame(int minWidth, int minHeight, int width, int height, String frameTitle)
    {
        super(frameTitle);
        
        this.minWidth = minWidth;
        this.minHeight = minHeight;
        this.width = width;
        this.height = height;
        this.frameTitle = frameTitle;
        
        this.graphicsEnvironment = GraphicsEnvironment.getLocalGraphicsEnvironment();
        this.awtToolkit = Toolkit.getDefaultToolkit();
    }
    
    /**
     * Initializes this frame.
     */
    public void initialize()
    {           
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        //Get size of the main display
        Dimension mainDisplaySize = this.awtToolkit.getScreenSize();
        
        //Calculate the center point of the main display
        int mainDisplayCenterPointX = (int) (mainDisplaySize.getWidth() / 2);
        int mainDisplayCenterPointY = (int) (mainDisplaySize.getHeight() / 2);
        
        //Since the window will generate from the top-left corner, even though
        //the center point has been calculated, it is needed to take into account
        //the window width and height for properly displaying the window at the
        //the center of the screen. In other words, both center coordinates of the
        //screen and the window must be aligned.
        int windowLocationX = mainDisplayCenterPointX - (width / 2);
        int windowLocationY = mainDisplayCenterPointY - (height / 2);
        
        //Display the window at the main display center
        this.setLocation(windowLocationX, windowLocationY);
        
        this.setMinimumSize(new Dimension(minWidth, minHeight));
        this.setSize(width, height);
        
        this.saluhudDatabaseUpdateMainJPanel = new SaluhudDatabaseUpdateMainJPanel(this);
        this.saluhudDatabaseUpdateMainJPanel.initialize();
        //this.setContentPane(saluhudDatabaseUpdateMainJPanel);
        
        this.setLayout(new BorderLayout());
        this.add(saluhudDatabaseUpdateMainJPanel, BorderLayout.CENTER);
        
        setAppIcon();
        
        this.pack();
        this.setVisible(true);
    }
    
    private void setAppIcon()
    {
        try
        {
            InputStream imageInputStream16x16 = getClass().getClassLoader().getResourceAsStream("images/Saluhud_logo_no_title_white_heart16x16.png");
            BufferedImage image16x16 = ImageIO.read(imageInputStream16x16);
            
            InputStream imageInputStream32x32 = getClass().getClassLoader().getResourceAsStream("images/Saluhud_logo_no_title_white_heart32x32.png");
            BufferedImage image32x32 = ImageIO.read(imageInputStream32x32);
            
            InputStream imageInputStream64x64 = getClass().getClassLoader().getResourceAsStream("images/Saluhud_logo_no_title_white_heart64x64.png");
            BufferedImage image64x64 = ImageIO.read(imageInputStream64x64);
            
            InputStream imageInputStream128x128 = getClass().getClassLoader().getResourceAsStream("images/Saluhud_logo_no_title_white_heart128x128.png");
            BufferedImage image128x128 = ImageIO.read(imageInputStream128x128);
            
            List<Image> icons = new ArrayList<>();
            
            icons.add(image16x16);
            icons.add(image32x32);
            icons.add(image64x64);
            icons.add(image128x128);
            
            this.setIconImages(icons);
            
        } catch (IOException ex)
        {
            Logger.getLogger(SaluhudDatabaseUpdateMainJPanel.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
        }
    }

    public SaluhudDatabaseUpdateMainJPanel getSaluhudDatabaseUpdateMainJPanel()
    {
        return saluhudDatabaseUpdateMainJPanel;
    }
}
