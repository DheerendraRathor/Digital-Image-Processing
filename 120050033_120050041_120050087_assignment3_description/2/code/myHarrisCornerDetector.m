function [harris, gx, gy, eigen_1_harris, eigen_2_harris, appended_image] = myHarrisCornerDetector(image, sigma, window, k)
    [rows, cols] = size(image);
       
    harris = zeros(rows, cols);
    eigen_1_harris = zeros(rows, cols);
    eigen_2_harris = zeros(rows, cols);
    
    rescaled_image = myIntensityRescale(image, 0.0, 1.0);    
%    [gx, gy] = imgradientxy(rescaled_image);
    gx = conv2(rescaled_image,  [-1, 0, 1 ; -2, 0, 2; -1, 0, 1], 'same');
    gy = conv2(rescaled_image,  [-1, -2, -1 ; 0, 0, 0; 1, 2, 1], 'same');
    
    gx2 = gx.^2;
    gy2 = gy.^2;
    gxy = gx.*gy;
    
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
          
            gx2_clip = sum(sum(g_clip.*gx2(r:R, c:C)));
            gy2_clip = sum(sum(g_clip.*gy2(r:R, c:C)));
            gxy_clip = sum(sum(g_clip.*gxy(r:R, c:C)));
           
            A = [gx2_clip, gxy_clip; gxy_clip, gy2_clip];
            harris(i, j) = det(A) - k*(trace(A).^2);
            
            eigen = eig(A);
            eigen_1_harris(i, j) = eigen(1);
            eigen_2_harris(i, j) = eigen(2);
            
        end
        waitbar(i/rows);
    end
    close(wb);
    
    appended_image = harris + rescaled_image./2;
      
%     figure; imshow(uint8(image));
%     figure; imshow(gx, [0, 1]);
%     figure; imshow(gy, [0, 1]);
%     figure; imshow(harris, [0, 1]);
%     figure; imshow(eigen_1_harris, [0, 1]);
%     figure; imshow(eigen_2_harris, [0, 1]);
%     figure; imshow(harris + rescaled_image./2, [0, 1]);

end