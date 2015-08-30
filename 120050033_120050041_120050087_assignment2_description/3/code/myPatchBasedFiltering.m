function patched_image = myPatchBasedFiltering(noisy_image, patch, window, sigma, gaussian_weight)
    [rows, cols] = size(noisy_image);
    patched_image = zeros(rows, cols);
    
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
    
    for i=1:rows
        for j=1:cols
            patched_image(i,j) = myGetPatchedPixel(noisy_image, [i,j], patch, window, sigma, gaussian_weight);
            
%%%%% Padding Based Algorithm %%%%%
%             patched_image(i,j) = myPaddingBasedPatchedPixel(noisy_image, [i,j], window, sigma, memoised_windowed_image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
        waitbar(i/rows);
    end
    close(wb);
end