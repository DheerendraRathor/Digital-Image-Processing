function out_image = myAHE(filename, n)
image = imread(filename);

sz = floor(n/2);
out_image = zeros(size(image, 1), size(image, 2));

for i = 1:size(image, 1)
    for j = 1:size(image, 2)
        lower_r = max([1, i - sz]);
        lower_c = max([1, j - sz]);
        
        higher_r = min([i + sz, size(image,1)]);
        higher_c = min([j + sz, size(image,2)]);
        [pixel_counts, levels] = imhist(image(lower_r:higher_r, lower_c:higher_c));
        %display(pixel_counts);
        pd_values = pixel_counts / ((higher_r - lower_r+1)*(higher_c - lower_c+1));
        %my_pd_values = createPdf(image, i, j, sz, sz);
        
        cd_func = createCdf(pd_values);
        out_image(i,j) = cd_func(image(i,j)+1)*255;
    end
end

out_image = uint8(out_image);
imshow(out_image);

end