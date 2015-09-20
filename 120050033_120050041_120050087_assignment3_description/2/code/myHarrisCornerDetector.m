function harris = myHarrisCornerDetector(image, sigma, window, k)
    [rows, cols] = size(image);
       
    harris = zeros(rows, cols);
    
    rescaled_image = myIntensityRescale(image, 0.0, 1.0);    
%    [gx, gy] = imgradientxy(rescaled_image);
    gx = conv2(rescaled_image,  [-1, 0, 1 ; -2, 0, 2; -1, 0, 1]; 
    g_mat = fspecial('gaussian', window, sigma);
    
    wb = waitbar(0, 'Harris Corner Detection Happening');
    for i = 1:rows
        for j = 1:cols
            rsz = floor(window(1,1)/2);
            csz = floor(window(1,2)/2);

            r = max([1, i - rsz]);
            R = min([i + rsz, rows]);
            c = max([1, j - csz]);    
            C = min([j + csz, cols]);
            
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
      
    images = zeros(rows, cols, 4);
    images(:, :, 1) = image;
    images(:, :, 2) = myIntensityRescale(gx, 0, 255);
    images(:, :, 3) = myIntensityRescale(gy, 0, 255);
    images(:, :, 4) = harris;
   
    myShowImages(images, 'Harris Corner Boat');
end