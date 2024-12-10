package com.uhu.saluhud.saluhud.database.updater.ui.components;

import com.uhu.saluhud.saluhud.database.updater.ui.general.LoadingDialog;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudButton extends JButton
{

    public static final Color BUTTON_COLOR = new Color(168, 10, 46);
    public static final Color HOVER_BUTTON_COLOR = new Color(143, 12, 46);
    public static final Color BUTTON_TEXT_COLOR = Color.WHITE;
    public static final Color HOVER_BUTTON_TEXT_COLOR = Color.WHITE;
    public static final Color BUTTON_CLICKED_TEXT_COLOR = new Color(168, 10, 46);
    public static final Color BUTTON_CLICKED_COLOR = Color.WHITE;

    private Color currentButtonColor = BUTTON_COLOR;
    private Color currentTextColor = BUTTON_TEXT_COLOR;
    
    private boolean isMouseOver = false;

    public SaluhudButton(String text)
    {
        super(text);

        this.setBorderPainted(false);

        this.addMouseListener(new MouseAdapter()
        {
            @Override
            public void mouseExited(MouseEvent e)
            {
                if(!isEnabled())
                {
                    return;
                }
                
                isMouseOver = false;
                setButtonColor(BUTTON_COLOR);
                setButtonTextColor(BUTTON_TEXT_COLOR);
                repaint();
            }

            @Override
            public void mouseEntered(MouseEvent e)
            {
                if(!isEnabled())
                {
                    return;
                }
                
                isMouseOver = true;
                setButtonColor(HOVER_BUTTON_COLOR);
                setButtonTextColor(HOVER_BUTTON_TEXT_COLOR);
                repaint();
            }

            @Override
            public void mouseReleased(MouseEvent e)
            {
                if(!isEnabled())
                {
                    return;
                }
                
                if(isMouseOver)
                {
                    setButtonColor(HOVER_BUTTON_COLOR);
                    setButtonTextColor(HOVER_BUTTON_TEXT_COLOR);
                }
                else
                {
                    setButtonColor(BUTTON_COLOR);
                    setButtonTextColor(BUTTON_TEXT_COLOR);
                }
                
                repaint();
            }

            @Override
            public void mousePressed(MouseEvent e)
            {
                if(!isEnabled())
                {
                    return;
                }
                
                setButtonColor(BUTTON_CLICKED_COLOR);
                setButtonTextColor(BUTTON_CLICKED_TEXT_COLOR);
                repaint();
            }
        });

        try
        {
            InputStream fontStream = getClass().getClassLoader().getResourceAsStream("fonts/JetBrainsMono-Regular.ttf");
            Font jetBrainsMono = Font.createFont(Font.TRUETYPE_FONT, fontStream).deriveFont(14f);
            this.setFont(jetBrainsMono);
        } catch (FontFormatException | IOException ex)
        {
            Logger.getLogger(SaluhudButton.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void paintComponent(Graphics g)
    {
        if(isEnabled())
        {
            Graphics2D g2 = (Graphics2D) g;

            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setColor(currentButtonColor);
            g2.fillRect(0, 0, getWidth(), getHeight());

            FontMetrics fm = g.getFontMetrics();

            int textPositionX = (getWidth() / 2) - (fm.stringWidth(getText()) / 2);
            int textPositionY = ((getHeight() - fm.getHeight()) / 2) + fm.getAscent();

            g2.setColor(currentTextColor);
            g2.drawString(getText(), textPositionX, textPositionY);
        }
        else
        {
            Graphics2D g2 = (Graphics2D) g;

            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setColor(Color.GRAY);
            g2.fillRect(0, 0, getWidth(), getHeight());

            FontMetrics fm = g.getFontMetrics();

            int textPositionX = (getWidth() / 2) - (fm.stringWidth(getText()) / 2);
            int textPositionY = ((getHeight() - fm.getHeight()) / 2) + fm.getAscent();

            g2.setColor(Color.darkGray);
            g2.drawString(getText(), textPositionX, textPositionY);
        }
        //super.paintComponent(g);
    }

    public void setButtonColor(Color color)
    {
        this.currentButtonColor = color;
    }

    public void setButtonTextColor(Color color)
    {
        this.currentTextColor = color;
    }
}
