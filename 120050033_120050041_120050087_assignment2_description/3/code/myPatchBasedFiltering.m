function patched_image = myPatchBasedFiltering(image, patch, window, sigma)
    addpath('../../common/');
    
    image = image(1:100,1:100);
    
    [rows, cols] = size(image);
    patched_image = zeros(rows, cols);
    noisy_image = myGaussianNoiser(image);
    
    wb = waitbar(0, 'Patch Based Filtering Happening');
    for i=1:rows
        tic;
        for j=1:cols
            patched_image(i,j) = myGetPatchedPixel(noisy_image, [i,j], patch, window, sigma);
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