function [bilateral_image, gaussian_mask] = myBilateralFiltering(image, window_size, sigmaD, sigmaR)
    addpath('../../common/');
    
    [rows, cols] = size(image);
    bilateral_image = zeros(rows, cols);
    noisy_image = myGaussianNoiser(image);
    gaussian_mask = noisy_image - image;

    wb = waitbar(0, 'Bilateral Filtering Happening');
    for i=1:rows
        for j=1:cols
            bilateral_image(i,j) = denoisePixel(noisy_image, [i,j],...
                window_size, sigmaD, sigmaR);
        end
        waitbar(i/rows);
    end
    close(wb);
    
%     show_images = zeros(rows, cols, 3);
%     show_images(:,:,1) = image;
%     show_images(:,:,2) = noisy_image;
%     show_images(:,:,3) = bilateral_image;
%     
%     myShowImages(show_images);
end