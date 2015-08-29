function patched_image = myPatchBasedFiltering(image, patch, window, sigma)
    addpath('../../common/');
    
    image = image(1:50,1:50);
    
    [rows, cols] = size(image);
    patched_image = zeros(rows, cols);
    noisy_image = myGaussianNoiser(image);
    
    wb = waitbar(0, 'Patch Based Filtering Happening');
    
    padding = floor(patch/2);
    padded_image = myPaddedImage(image, [padding, padding]);
    memoised_windowed_image = zeros(rows, cols, patch, patch);
    gaussian_weight = fspecial('gaussian', [patch, patch]);
    for i = padding+1:padding+rows
        for j = padding+1:padding+cols
            memoised_windowed_image(i, j, :, :) = ...
                gaussian_weight.*myGetWindow(padded_image, [i, j], [patch, patch]);
        end
    end
    
    for i=1:rows
        tic;
        for j=1:cols
            patched_image(i,j) = myPaddingBasedPatchedPixel(noisy_image, ...
                [i,j], window, sigma, memoised_windowed_image);
        end
        toc;
        waitbar(i/rows);
    end
    close(wb);         
    
    show_images = zeros(rows, cols, 3);
    show_images(:,:,1) = image(:,:);
    show_images(:,:,2) = noisy_image(:,:);
    show_images(:,:,3) = patched_image(:,:);
    
    myShowImages(show_images);
    patched_image = uint8(patched_image);
end