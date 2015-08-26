function denoisedPixel = myTrialDenoiseImage(image, p1, window_size, sigmaD, sigmaR)
    [rows, cols] = size(image);
    i = p1(1,1);
    j = p1(1,2);
    sz = floor(window_size/2);
    lower_r = max([1, i - sz]);
    higher_r = min([i + sz, rows]);
    lower_c = max([1, j - sz]);    
    higher_c = min([j + sz, cols]);
    
    [meshX, meshY] = meshgrid(-sz:sz, -sz:sz);
    space_gaussian_helper = exp( -(meshX.^2 + meshY.^2)/(2*sigmaD^2) );
    space_guassian = space_gaussian_helper(...
        (lower_r:higher_r)-i+sz+1,...
        (lower_c:higher_c)-j+sz+1);
    
    submatrix = image(lower_r:higher_r, lower_c:higher_c);
    intensity_gaussian = exp( -(submatrix - image(i,j)).^2/(2*sigmaR^2) );
    
    display(submatrix);
    display(space_guassian);
    display(intensity_gaussian);
    weight = space_guassian.*intensity_gaussian;
    weighted_intensity = weight.*submatrix;
    
    display(weighted_intensity);
    display(weight);
    
    denoisedPixel = sum(weighted_intensity)/sum(weight);
end