package com.uhu.saluhud.saluhud.database.updater.ui.util;

import java.awt.Dimension;
import java.awt.Image;
import java.awt.image.BufferedImage;

/**
 * Utility methods for working with images
 * 
 * @author Saúl Rodríguez Naranjo
 */
public class ImageUtils 
{
    public static Image scaleImageWithinBoundaries(BufferedImage image, Dimension containerSize, boolean maintainAspectRatio)
    {   
        if(maintainAspectRatio)
        {
            return scaleImageMaintainingAspectRatio(image, containerSize);
        }
        
        return null;
    }
    
    public static Image scaleImageMaintainingAspectRatio(BufferedImage image, Dimension newImageSize)
    {
        int originalWidth = image.getWidth();
        int originalHeight = image.getHeight();
        double aspectRatio = (double) originalWidth / originalHeight;

        int newWidth = (int) newImageSize.getWidth();
        int newHeight = (int) ((int) newImageSize.getWidth() / aspectRatio);
        
        if(newHeight > (int) newImageSize.getHeight())
        {
            newHeight = (int) newImageSize.getHeight();
            newWidth = (int) (newImageSize.getHeight() * aspectRatio);
        }
        
        return image.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
    }
}
