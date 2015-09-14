function [out_image] = myButterworthFiltering(noisy_image, d0, n)
      
    fourier = fft2(noisy_image);
    fourier_shifted = fftshift(fourier);
    filter = myButterworthFilter(d0, n, size(fourier_shifted));
    
    filtered_fourier = filter.*fourier_shifted;
    out_image = abs(ifft2(filtered_fourier));
    
end