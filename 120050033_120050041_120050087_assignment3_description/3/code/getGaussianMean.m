function [new_rgb] = getGaussianMean(window, rgb, radius)
    [rows, cols, dim] = size(window);
    rgb_matrix = [rgb(1, 1, 1), rgb(1, 1, 2), rgb(1, 1, 3)];
    
    n_window = window;
    for i=1:rows
        for j=1:cols
            n_window(i,j,1) = n_window(i,j,1) - rgb_matrix(1,1);
            n_window(i,j,2) = n_window(i,j,2) - rgb_matrix(1,2);
            n_window(i,j,3) = n_window(i,j,3) - rgb_matrix(1,3);
        end
    end
    
    sum_matrix = [0, 0, 0];
    gaussian_kernel = fspecial('gaussian', [255, 255, 255], radius);
    weight = 0;
    
    for i=1:rows
        for j=1:cols
            pixel = [window(i,j,1), window(i,j,2), window(i,j,3)];
            n_pixel = [n_window(i,j,1), n_window(i,j,2), n_window(i,j,3)];
            weight = weight + gaussian_kernel(n_pixel(1,1), n_pixel(1,2), n_pixel(1,3));
            sum_matrix = sum_matrix + gaussian_kernel(n_pixel(1,1), n_pixel(1,2), n_pixel(1,3))*pixel;
        end
    end
    mean = sum_matrix;
    new_rgb = cat(3, mean(1,1), mean(1,2), mean(1,3));
end

