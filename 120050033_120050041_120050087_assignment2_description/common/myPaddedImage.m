function padded_image = myPaddedImage(image, padding)
    rsize = size(image, 1) + 2*padding(1, 1);
    csize = size(image, 2) + 2*padding(1, 2);
    
    padded_image = zeros(rsize, csize);
    
    rmin = padding(1,1)+1;
    rmax = rsize - padding(1,1);
    
    cmin = padding(1,2)+1;
    cmax = csize - padding(1,2);
    
    padded_image(rmin:rmax, cmin:cmax) = image;
end