function patched_image = myPatchBasedFiltering(image, patch, window, sigma)
    addpath('../../common/');
    
    image = image(1:50,1:50);
    image = myLinearContrastStretching(image);
    
    [rows, cols] = size(image);
    patched_image = zeros(rows, cols);
    noisy_image = myGaussianNoiser(image);
    
    wb = waitbar(0, 'Patch Based Filtering Happening');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Padding Based Algorithm %%%%%
%     padding = floor(patch/2);
%     padded_image = myPaddedImage(image, [padding, padding]);
%     memoised_windowed_image = zeros(rows, cols, patch, patch);
%     gaussian_weight = fspecial('gaussian', [patch, patch]);
%     for i = padding+1:padding+rows
%         for j = padding+1:padding+cols
%             memoised_windowed_image(i, j, :, :) = ...
%                 gaussian_weight.*myGetWindow(padded_image, [i, j], [patch, patch]);
%         end
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tic;
    for i=1:rows
        for j=1:cols
            patched_image(i,j) = myGetPatchedPixel(noisy_image, [i,j], patch, window, sigma);
            
%%%%% Padding Based Algorithm %%%%%
%             patched_image(i,j) = myPaddingBasedPatchedPixel(noisy_image, [i,j], window, sigma, memoised_windowed_image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
        waitbar(i/rows);
    end
    toc;
    close(wb);
    
    rmds = myRMSDofImage(image, noisy_image);
    display(rmds);
    
    rmds = myRMSDofImage(image, patched_image);
    display(rmds);
    
    patched_image = uint8(patched_image);
    
    figure;
    imagesc(image);
    
    figure;
    imagesc(uint8(noisy_image));
    
    figure;
    imagesc(patched_image);
    
end