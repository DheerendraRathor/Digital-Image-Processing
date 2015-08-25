function denoisedPixel = denoisePixel(image, p1, window_size, sigmaD, sigmaR)
    [rows, cols] = size(image);
    i = p1(1,1);
    j = p1(1,2);
    sz = floor(window_size/2);
    lower_r = max([1, i - sz]);
    higher_r = min([i + sz, rows]);
    lower_c = max([1, j - sz]);    
    higher_c = min([j + sz, cols]);
    
     sum_w = 0;
     sum_wi = 0;
     for x=lower_r:higher_r
         for y=lower_c:higher_c
             weight = pixelWeight(image, p1, [x, y], sigmaD, sigmaR);
             sum_w = sum_w + weight;
             sum_wi = sum_wi + (image(x, y)*weight);
         end
     end
     denoisedPixel = sum_wi/sum_w;
end