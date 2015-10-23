function denoised_image= myPCADenoising2(image, patch_size, neighbourhood, k, sigma)
    [padded_image, rmin, rmax, cmin, cmax] = myPaddedImageValued(image, neighbourhood + patch_size);
    patch_size_half = floor(patch_size(1,1)/2);
    patch_points = patch_size(1,1)*patch_size(1,2);
    
    padded_denoised_image = zeros(size(padded_image, 1), size(padded_image, 2));
    count = zeros(size(padded_image, 1), size(padded_image, 2));
    
    wb = waitbar(0, 'PCA Denoising');
    index = 1;
    for row = rmin:rmax
        for column = cmin:cmax
            
            row_range = row-patch_size_half:row+patch_size_half;
            col_range = column-patch_size_half:column+patch_size_half;
            
            image_patch = padded_image(row_range, col_range);
            row_top_left = row - patch_size_half;
            column_top_left = column - patch_size_half;
            window_half = floor(neighbourhood(1,1)/2);
            
            brrange = max(row_top_left - window_half, rmin):min(row_top_left + window_half, rmax);
            bcrange = max(column_top_left - window_half, cmin):min(column_top_left + window_half, cmax);
            patches = zeros(size(brrange, 2)*size(bcrange, 2), patch_points);
            
            position = 1;
            for bro = brrange
                for bcol = bcrange
                    image_sub_patch = padded_image(bro-patch_size_half:bro+patch_size_half, ...
                        bcol-patch_size_half:bcol+patch_size_half);
                    image_sub_patch = reshape(image_sub_patch, 1, patch_points);
                    patches(position, :) = image_sub_patch;
                    position = position + 1;
                end
            end
            
            kval = min(k, size(brrange, 2)*size(bcrange, 2));
            image_patch = reshape(image_patch, 1, numel(image_patch));
            nearests = knnsearch(patches, image_patch, 'k', kval);
                        
            P = zeros(patch_points, kval);
            for nearest = 1:kval
                P(:,nearest) = patches(nearests(1, nearest), :)';
            end
            clear 'patches';
            
            C = P * P';
            [Evec, Eval] = eig(C);
            clear 'C';
            
            Vn = Evec;
            A = Vn'*P;
            A2 = A.*A;
            A_Bar = sum(A2')./kval - sigma*sigma;
            Wiener = 1./(1 + (sigma*sigma)./(A_Bar'));
            clear 'A_Bar';
            
            B = zeros(size(A,1) ,size(A,2));
            for i = 1:size(A,2)
               B(:, i) = Wiener .* A(:, i);
            end
            
            denoised_patches = Vn*B;
            padded_denoised_image(row_range, col_range) = padded_denoised_image(row_range, col_range) ...
                + reshape(denoised_patches(:, 1), patch_size(1,1), patch_size(1,2));
            
            count(row_range, col_range) = count(row_range, col_range) + 1.0;
            waitbar(index/numel(image));
            index = index + 1;
        end
    end
    close(wb);
    denoised_image = padded_denoised_image(rmin:rmax, cmin:cmax) ./ count(rmin:rmax, cmin:cmax);
    
end