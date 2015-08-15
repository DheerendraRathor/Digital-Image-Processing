function out_image = processColoredImage(image, functionHandle)
    image_r = image(:,:,1);
    image_g = image(:,:,2);
    image_b = image(:,:,3);
    processed_image_r = functionHandle(image_r);
    processed_image_g = functionHandle(image_g);
    processed_image_b = functionHandle(image_b);
    out_image = cat(3, processed_image_r, processed_image_g, processed_image_b);
end