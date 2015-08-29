function pixel = myGetPatchedPixel(image, point, patch, window, sigma)
    focused_patch = myGetWindow(image, point, [patch, patch]);
    gaussian_weight = fspecial('gaussian', [patch, patch]);
    
    [a,b,l,r] = myGetWindowDelta(image, point, [patch, patch]);
    focused_delta = [a,b,l,r];
    
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, [window, window]);
    
    weight_sum = 0;
    intensity_sum = 0;
    
    for i = rmin:rmax
        for j = cmin:cmax
            current_patch = myGetWindow(image, [i, j], [patch, patch]);
            [a,b,l,r] = myGetWindowDelta(image, [i, j], [patch, patch]);
            current_delta = [a,b,l,r];
            
            euclidian_dist = myGetWeight(current_patch, focused_patch,...
                current_delta, focused_delta, gaussian_weight);
            weight = exp(-euclidian_dist/(sigma.^2));
            intensity_sum = intensity_sum + weight*image(i,j);
            weight_sum = weight_sum + weight;
        end
    end
    
    pixel = intensity_sum/weight_sum;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hack function to compute norm difference for two matrices which are of unequal sizes
function euclidian_dist = myGetWeight(current, focused, d1, d2, gaussian)
    [r1, c1] = size(current);
    [r2, c2] = size(focused);
    [rg, cg] = size(gaussian);
    
    d = max(d1, d2);
    
    range_r1 = (1+ d(1,1) - d1(1,1)):(r1 - d(1,2) + d1(1,2));
    range_c1 = (1+ d(1,3) - d1(1,3)):(c1 - d(1,4) + d1(1,4));
    
    range_r2 = (1+ d(1,1) - d2(1,1)):(r2 - d(1,2) + d2(1,2));
    range_c2 = (1+ d(1,3) - d2(1,3)):(c2 - d(1,4) + d2(1,4));
    
    range_rg = (1 + d(1,1)):(rg - d(1,2));
    range_cg = (d(1,3)+1):(cg - d(1,4));
    
    diff_matrix = current(range_r1, range_c1) - focused(range_r2, range_c2);
    euclidian_dist = norm(gaussian(range_rg, range_cg).*diff_matrix);
end