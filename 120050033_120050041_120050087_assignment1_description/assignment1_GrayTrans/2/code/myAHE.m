function out_image = myAHE(image, window_size)
[rows, cols] = size(image);
sz = floor(window_size/2);
out_image = zeros(size(image, 1), size(image, 2));

wb = waitbar(0, 'AHE - Progressing');
for i = 1:rows
    lower_r = max([1, i - sz]);
    higher_r = min([i + sz, rows]);
    for j = 1:cols
        lower_c = max([1, j - sz]);    
        higher_c = min([j + sz, cols]);
        
        pd_values = pdf(image,lower_r,higher_r,lower_c,higher_c);
        
        cd_func = cumsum(pd_values);
        out_image(i,j) = cd_func(image(i,j)+1)*255;
    end
    waitbar(i/rows);
end
close(wb);

out_image = uint8(out_image);

end