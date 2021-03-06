function [new_rgb] = getMean(window, rgb, radius)
    [rows, cols, dim] = size(window);
    rgb_matrix = [rgb(1, 1, 1), rgb(1, 1, 2), rgb(1, 1, 3)];
    sum_matrix = [0, 0, 0];
    total_pixels = 0.0;
    
    gaussian_kernel = fspecial('gaussian', [rows, cols], radius(1,1));
    
    for i=1:rows
        for j=1:cols
            pixel = [window(i,j,1), window(i,j,2), window(i,j,3)];
            distance = myRGBDistance(pixel, rgb_matrix);
            if distance < radius(1,2)
                total_pixels = total_pixels + gaussian_kernel(i,j);
                sum_matrix = sum_matrix + gaussian_kernel(i,j)*pixel;
            end
        end
    end
    
    mean = sum_matrix/total_pixels;
    new_rgb = cat(3, mean(1,1), mean(1,2), mean(1,3));
end

