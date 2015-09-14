function out_image = myIntensityRescale(image, r_min, r_max)

minimum = double(min(image(:)));
maximum = double(max(image(:)));
out_image = image;

range = r_max - r_min;

if (minimum < maximum)
    p = range / (maximum - minimum);
    
    shifted_image = image - minimum;
    scaled_image = p * shifted_image;
    out_image = scaled_image + r_min;
    
end

end