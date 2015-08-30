function pixel = myGetPatchedPixel(image, point, patch, window, sigma, gaussian_weight)
    focused_patch = myGetWindow(image, point, [patch, patch]);
    focused_padding = myGetWindowPadding(image, point, [patch, patch]);
    
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, [window, window]);
    
    weights = zeros(rmax - rmin + 1, cmax - cmin + 1);
    for i = rmin:rmax
        for j = cmin:cmax
            current_patch = myGetWindow(image, [i, j], [patch, patch]);
            current_padding = myGetWindowPadding(image, [i, j], [patch, patch]);
            
            weights(i - rmin + 1, j - cmin + 1)  = myGetWeight(current_patch, focused_patch,...
                current_padding, focused_padding, gaussian_weight, sigma);
        end
    end
    
    weights = weights/sum(weights(:));
    weighted_intensities = image(rmin:rmax, cmin:cmax).*weights;
    pixel = sum(weighted_intensities(:));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hack function to compute norm difference for two matrices which are of unequal sizes
function weight = myGetWeight(current, focused, d1, d2, gaussian, sigma)
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
    weight = exp(-euclidian_dist/(sigma.^2));
end