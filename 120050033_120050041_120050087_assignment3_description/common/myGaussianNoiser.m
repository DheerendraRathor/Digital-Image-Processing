function noisy_image = myGaussianNoiser(image, variance)
    maximum_intensity = max(image(:));
    minimum_intensity = min(image(:));
    
    standard_deviation = variance*(maximum_intensity - minimum_intensity);
    
    noisy_image = standard_deviation*randn(size(image, 1), size(image, 2)) + image;
end