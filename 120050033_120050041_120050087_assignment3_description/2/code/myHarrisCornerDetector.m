function corner_detected_image = myHarrisCornerDetector(image, sigma, window, k)
    [rows, cols] = size(image);
       
    corner_detected_image = zeros(rows, cols);
    
    rescaled_image = myIntensityRescale(image, 0.0, 1.0);    
    [g_x, g_y] = imgradientxy(rescaled_image);
    
    gaussian_mat = fspecial('gaussian', window, sigma);
    wb = waitbar(0, 'Harris Corner Detection Happening');
    for i = 1:rows
        for j = 1:cols
            point = [i, j];
            [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, window);
            gaussian_clipped = myGetExactWindow(gaussian_mat, ceil(window/2), [rmax - rmin, cmax - cmin]); 
           
            Ix_2_weighted_sum = sum(sum(gaussian_clipped.*(g_x(rmin:rmax, cmin:cmax).^2)));
            Iy_2_weighted_sum = sum(sum(gaussian_clipped.*(g_y(rmin:rmax, cmin:cmax).^2)));
            Ixy_weighted_sum = sum(sum(gaussian_clipped.*(g_x(rmin:rmax, cmin:cmax).*g_y(rmin:rmax, cmin:cmax))));

            structure_tensor = [Ix_2_weighted_sum, Ixy_weighted_sum; Ixy_weighted_sum, Iy_2_weighted_sum];
            corner_detected_image(i, j) = sign( det(structure_tensor) - k*(trace(structure_tensor).^2) );
        end
        waitbar(i/rows);
    end
    close(wb);
      
    images = zeros(rows, cols, 4);
    images(:, :, 1) = image;
    images(:, :, 2) = corner_detected_image;
    images(:, :, 3) = g_x;
    images(:, :, 4) = g_y;
   
    myShowImages(images, 'Harris Corner Boat');
end