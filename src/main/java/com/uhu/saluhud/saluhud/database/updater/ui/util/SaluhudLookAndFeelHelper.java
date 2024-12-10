package com.uhu.saluhud.saluhud.database.updater.ui.util;

import com.uhu.saluhud.saluhud.database.updater.ui.general.SaluhudScrollBarUI;
import java.awt.Color;

/**
 *
 * @author Saúl Rodríguez Naranjo
 */
public class SaluhudLookAndFeelHelper 
{
    public static Color UHU_MAIN_RED_COLOR = new Color(168, 10, 46);
    
    public static SaluhudScrollBarUI getSaluhudScrollBarUI()
    {
        return new SaluhudScrollBarUI();
    }
}
