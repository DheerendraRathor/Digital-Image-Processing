function bilateral_image = myBilateralFiltering(noisy_image, window_size, sigmaD, sigmaR)
    addpath('../../common/');
    
    [rows, cols] = size(noisy_image);
    bilateral_image = zeros(rows, cols);

    wb = waitbar(0, 'Bilateral Filtering Happening');
    for i=1:rows
        for j=1:cols
            bilateral_image(i,j) = denoisePixel(noisy_image, [i,j],...
                window_size, sigmaD, sigmaR);
        end
        waitbar(i/rows);
    end
    close(wb);

end