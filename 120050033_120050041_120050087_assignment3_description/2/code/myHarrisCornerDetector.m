function harris = myHarrisCornerDetector(image, sigma, window, k)
    [rows, cols] = size(image);
       
    harris = zeros(rows, cols);
    
    rescaled_image = myIntensityRescale(image, 0.0, 1.0);    
    [gx, gy] = imgradientxy(rescaled_image);
    
    g_mat = fspecial('gaussian', window, sigma);
    wb = waitbar(0, 'Harris Corner Detection Happening');
    for i = 1:rows
        for j = 1:cols
            point = [i, j];
            [r, R, c, C] = myGetWindowBoundaries(image, point, window);
            g_clip = myGetExactWindow(g_mat, ceil(window/2), [R - r, C - c]); 
           
            gx2 = sum(sum(g_clip.*(gx(r:R, c:C).^2)));
            gy2 = sum(sum(g_clip.*(gy(r:R, c:C).^2)));
            gxy = sum(sum(g_clip.*(gx(r:R, c:C).*gy(r:R, c:C))));

            A = [gx2, gxy; gxy, gy2];
 
            harris(i, j) = sign( det(A) - k*(trace(A).^2) );
        end
        waitbar(i/rows);
    end
    close(wb);
      
    images = zeros(rows, cols, 5);
    images(:, :, 1) = image;
    images(:, :, 2) = rescaled_image;
    images(:, :, 3) = harris;
    images(:, :, 4) = gx;
    images(:, :, 5) = gy;
   
    myShowImages(images, 'Harris Corner Boat');
end