function noisy_image = myGaussianNoiser(image)
    maximum_intensity = max(max(image));
    minimum_intensity = min(min(image));
    
    standard_deviation = 0.05*(maximum_intensity - minimum_intensity);
    
    noisy_image = uint8(standard_deviation*randn(size(image, 1), size(image, 2)) + image);
end