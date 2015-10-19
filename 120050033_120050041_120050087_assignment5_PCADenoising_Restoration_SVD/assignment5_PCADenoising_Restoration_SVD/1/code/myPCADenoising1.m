function denoised_image= myPCADenoising1(image, patch, sigma)
    [padded_image, rmin, rmax, cmin, cmax] = myPaddedImageValued(image, patch);
    patch_half = floor(patch/2);
    points = patch(1,1)*patch(1,2);
    ref = floor(points/2);
    P = zeros(points, numel(image));
    
    patch_index = 1;
    for row = rmin:rmax
        for column = cmin:cmax
            image_patch = myGetExactWindow(padded_image, [row, column], patch);
            image_patch = reshape(image_patch, numel(image_patch), 1);
            P(:, patch_index) = image_patch;
            patch_index = patch_index + 1;
        end
    end
    
    C = P * P';
    
    [Evec, Eval] = eig(C);
    clear 'C';
    
    % Normalizing these eigen vectors
    Vn = normc(Evec);
    
    % project the dataset
    A = Vn'*P;
    
    A2 = A.*A;
    A_Bar = sum(A2')./numel(image) - sigma*sigma;
    Wiener = 1./(1 + (sigma*sigma)./(A_Bar'));
    clear 'A_Bar';
    
    B = zeros(size(A,1) ,size(A,2));
    for i = 1:size(A,2)
       B(:, i) = Wiener .* A(:, i);
    end
    
    denoised_patches = Vn*B;
    
    padded_denoised_image = zeros(size(padded_image, 1), size(padded_image, 2));
    count = zeros(size(padded_image, 1), size(padded_image, 2));
    counter = 1;
    for row = rmin:rmax
        for col = cmin:cmax
            row_range = row-patch_half:row+patch_half;
            col_range = col-patch_half:col+patch_half;
            padded_denoised_image(row_range, col_range) = padded_denoised_image(row_range, col_range) ...
                + reshape(denoised_patches(:, counter), patch(1,1), patch(1,2));
            counter = counter + 1;
            count(row_range, col_range) = count(row_range, col_range) + 1.0;
        end
    end
    
    denoised_image = padded_denoised_image(rmin:rmax, cmin:cmax) ./ count(rmin:rmax, cmin:cmax);
end