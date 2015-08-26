function bilateral_image = myBilateralFiltering(image)
    addpath('../../common/');
    
    [rows, cols] = size(image);
    bilateral_image = zeros(rows, cols);
    noisy_image = myGaussianNoiser(image);
    
    wb = waitbar(0, 'Bilateral Filtering Happening');
    for i=1:rows
        for j=1:cols
            bilateral_image(i,j) = denoisePixel(noisy_image, [i,j], 5, 0.1, 0.1);
        end
        waitbar(i/rows);
    end
    close(wb);         
    
    show_images = zeros(rows, cols, 3);
    show_images(:,:,1) = image(:,:);
    show_images(:,:,2) = noisy_image(:,:);
    show_images(:,:,3) = bilateral_image(:,:);
    
    myShowImages(show_images);
    bilateral_image = uint8(bilateral_image);
end