function [energy_ratio] = myFourierEnergy(image, radii)
    fourier = fft2(image);
    s_fourier = fftshift(fourier);

    power = s_fourier.*conj(s_fourier);
    
    [rows, cols] = size(power);
    cr = ceil(rows/2);
    cc = ceil(cols/2);
    
    filtered = zeros(rows, cols);
    for i = 1:rows
        for j = 1:cols
            distance = pdist([i, j; cr, cc], 'euclidean');
            if (distance <= radii)
                filtered(i, j) = power(i, j);
            end
        end
    end
    
    energy_ratio = sum(filtered(:))/sum(power(:));
end