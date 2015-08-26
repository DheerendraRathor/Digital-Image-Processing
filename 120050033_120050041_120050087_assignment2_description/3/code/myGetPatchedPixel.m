function pixel = myGetPatchedPixel(image, point, patch, window, sigma)
    focussed_patch = myGetWindow(image, point, [patch, patch]);
    gaussian_weight = fspecial('gaussian', size(focussed_patch));
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, [window, window]);
    
    weight_sum = 0;
    intensity_sum = 0;
    
    for i = rmin:rmax
        for j = cmin:cmax
            current_patch = myGetWindow(image, [i, j], [patch, patch]);
            difference = myGetDifference(current_patch, focussed_patch);
            t_gaussian = gaussian_weight(1:size(difference,1), 1:size(difference,2));
            euclidian_dist = norm(t_gaussian.*difference);
            weight = exp(-euclidian_dist/(sigma.^2));
            intensity_sum = intensity_sum + weight*image(i,j);
            weight_sum = weight_sum + weight;
        end
    end
    
    pixel = intensity_sum/weight_sum;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hack function to compute norm difference for two matrices which are of unequal sizes
function diff_val = myGetDifference(mat1, mat2)
    [r1, c1] = size(mat1);
    [r2, c2] = size(mat2);
    
    rmin = min(r1, r2);
    cmin = min(c1, c2);
    
    diff_val = mat1(1:rmin, 1:cmin) - mat2(1:rmin, 1:cmin);
end