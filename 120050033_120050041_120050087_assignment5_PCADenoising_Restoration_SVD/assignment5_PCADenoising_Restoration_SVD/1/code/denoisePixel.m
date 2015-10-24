function denoisedPixel = denoisePixel(image, p1, window_size, sigmaD, sigmaR)
    
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, p1, [window_size, window_size]);
    
    i = p1(1,1);
    j = p1(1,2);
    
    window_submatrix = image(rmin:rmax, cmin:cmax);
    [meshX, meshY] = meshgrid(1:cmax-cmin+1, 1:rmax-rmin+1);
    new_i = i - rmin + 1;
    new_j = j - cmin + 1;
    
    row_diff = (meshY - new_i).^2;
    col_diff = (meshX - new_j).^2;
    distance_weight_factor = (row_diff + col_diff)/(2*(sigmaD.^2));
    intensity_weight_factor = ((window_submatrix - image(i,j)).^2)/(2*(sigmaR.^2));

    weight_matrix = exp(-(distance_weight_factor + intensity_weight_factor));
    intensity_weight = sum(sum(window_submatrix .* weight_matrix));
    denoisedPixel = intensity_weight/sum(sum(weight_matrix));

end