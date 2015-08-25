function bilateral_image = myBilateralFiltering(image)
    [row, col] = size(image);
    bilateral_image = zeros(row, col);
    noisy_image = myGaussianNoiser(image);
    
    wb = waitbar(0, 'Bilateral Filtering Happening');
    for i=1:row
        for j=1:col
            bilateral_image(i,j) = denoisePixel(noisy_image, [i,j], 5, 0.1, 0.1);
        end
        waitbar(i/row);
    end
           
    close(wb);         
    myShowImages(uint8(noisy_image), uint8(bilateral_image));
end