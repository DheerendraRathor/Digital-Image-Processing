function corner_detected_image = myHarrisCornerDetector(image)
    [rows, cols] = size(image);
    
    rescaled_image = myIntensityRescale(image, 0.0, 1.0);
    corner_detected_image = rescaled_image;
    
    [g_x, g_y] = imgradientxy(rescaled_image);
    
    images = zeros(rows, cols, 4);
    images(:, :, 1) = image;
    images(:, :, 2) = corner_detected_image;
    images(:, :, 3) = g_x;
    images(:, :, 4) = g_y;
   
    myShowImages(images, 'Harris Corner Boat');
end