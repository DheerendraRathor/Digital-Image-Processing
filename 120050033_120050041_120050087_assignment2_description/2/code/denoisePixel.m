function denoisedPixel = denoisePixel(image, p1, window_size, sigmaD, sigmaR)
    
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, p1, [window_size, window_size]);
    
    i = p1(1,1);
    j = p1(1,2);
    
    windows_submatrix = image(rmin:rmax, cmin:cmax);
    [meshX, meshY] = meshgrid(1:cmax-cmin+1, 1:rmax-rmin+1);
    new_i = i - rmin + 1;
    new_j = j - cmin + 1;
    
    row_diff = (meshY - new_i).^2;
    col_diff = (meshX - new_j).^2;
    distance_blah = (row_diff + col_diff)/(2*(sigmaD.^2));
    intensity_blah = ((windows_submatrix - image(i,j)).^2)/2*(sigmaR.^2);
    weight_matrix = exp(-(distance_blah + intensity_blah));
    
    intensity_weight = sum(windows_submatrix.*weight_matrix);
    denoisedPixel = intensity_weight/sum(weight_matrix);
    
    
%     sum_w = 0;
%     sum_wi = 0;
%     for x=rmin:rmax
%         for y=cmin:cmax
%             weight = pixelWeight(image, p1, [x, y], sigmaD, sigmaR);
%             sum_w = sum_w + weight;
%             sum_wi = sum_wi + (image(x, y)*weight);
%         end
%     end
%     denoisedPixel = sum_wi/sum_w;
end