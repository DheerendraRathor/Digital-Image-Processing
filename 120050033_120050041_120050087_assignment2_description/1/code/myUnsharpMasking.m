function filtered_image = myUnsharpMasking(image, gaussian_dimension, scaling)
    gaussian_filter = fspecial('gaussian', gaussian_dimension);
    filtered_image = imfilter(image, gaussian_filter);
    filtered_image = image + scaling*(image - filtered_image);
end