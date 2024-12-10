package com.uhu.saluhud.saluhud.database.updater.ui.general;

import com.uhu.saluhud.saluhud.database.updater.ui.util.SaluhudLookAndFeelHelper;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Rectangle;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.UIManager;
import javax.swing.plaf.basic.BasicArrowButton;
import javax.swing.plaf.basic.BasicScrollBarUI;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudScrollBarUI extends BasicScrollBarUI
{

    @Override
    protected void paintThumb(Graphics g, JComponent c, Rectangle thumbBounds)
    {
        if(thumbBounds.isEmpty() || !scrollbar.isEnabled())     {
            return;
        }

        int w = thumbBounds.width;
        int h = thumbBounds.height;

        g.translate(thumbBounds.x, thumbBounds.y);

        g.setColor(SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR);
        
        g.fillRect(0, 0, w - 1, h - 1);

        g.translate(-thumbBounds.x, -thumbBounds.y);
    }

    @Override
    protected void paintTrack(Graphics g, JComponent c, Rectangle trackBounds)
    {
        super.paintTrack(g, c, trackBounds);
    }
    
    @Override
    protected JButton createDecreaseButton(int orientation)
    {
        return new BasicArrowButton(orientation,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR,
                                    Color.WHITE,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR);
    }

    @Override
    protected JButton createIncreaseButton(int orientation)
    {
        return new BasicArrowButton(orientation,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR,
                                    Color.WHITE,
                                    SaluhudLookAndFeelHelper.UHU_MAIN_RED_COLOR);
    }

}
