function pixel = myGetPatchedPixel(image, point, patch, window, sigma)
    focussed_patch = myGetWindow(image, point, [patch, patch]);
    gaussian_weight = fspecial('gaussian', size(focussed_patch));
%     display(gaussian_weight);
    
    [a,b,l,r] = myGetWindowDelta(image, point, [patch, patch]);
    focussed_delta = [a,b,l,r];
    
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, [window, window]);
    
    weight_sum = 0;
    intensity_sum = 0;
    
    for i = rmin:rmax
        for j = cmin:cmax
            current_patch = myGetWindow(image, [i, j], [patch, patch]);
            [a,b,l,r] = myGetWindowDelta(image, [i, j], [patch, patch]);
            current_delta = [a,b,l,r];
            
            euclidian_dist = myGetWeight(current_patch, focussed_patch,...
                current_delta, focussed_delta, gaussian_weight);
            weight = exp(-euclidian_dist/(sigma.^2));
            intensity_sum = intensity_sum + weight*image(i,j);
            weight_sum = weight_sum + weight;
        end
    end
    
    pixel = intensity_sum/weight_sum;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hack function to compute norm difference for two matrices which are of unequal sizes
function euclidian_dist = myGetWeight(mat1, mat2, delta1, delta2, gaussian_wt)
    [r1, c1] = size(mat1);
    [r2, c2] = size(mat2);
    
    delta_max = max(delta1, delta2);
    range_r1 = (1+ delta_max(1,1) - delta1(1,1)):(r1 - delta_max(1,2) + delta1(1,2));
    range_c1 = (1+ delta_max(1,3) - delta1(1,3)):(c1 - delta_max(1,4) + delta1(1,4));
    
    range_r2 = (1+ delta_max(1,1) - delta2(1,1)):(r2 - delta_max(1,2) + delta2(1,2));
    range_c2 = (1+ delta_max(1,3) - delta2(1,3)):(c2 - delta_max(1,4) + delta2(1,4));
   
    diff_matrix = mat1(range_r1, range_c1) - mat2(range_r2, range_c2);
    euclidian_dist = norm(gaussian_wt(range_r2, range_c2).*diff_matrix);
end