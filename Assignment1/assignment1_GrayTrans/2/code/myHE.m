function out_image = myHE(filename)
image = imread(filename);

rows_by_2 = uint32(size(image, 1)/2);
col_by_2 = uint32(size(image, 2)/2);

pdf = createPdf(image, rows_by_2, col_by_2, rows_by_2+1, col_by_2+1);
%[pdf, levels] = imhist(image);
%pdf = pdf / numel(levels);
cdf = createCdf(pdf);
%scatter(1:256, cdf); 

out_image = zeros(size(image, 1), size(image, 2));

for i = 1:size(image, 1)
    for j = 1:size(image, 2)
        out_image(i,j) = cdf(image(i,j)+1)*255;
    end
end

out_image = uint8(out_image);

%out_pdf = createPdf(out_image, rows_by_2, col_by_2, rows_by_2+1, col_by_2+1);
%out_cdf = createCdf(out_pdf);
%scatter(1:256, out_cdf); 

imshow(out_image);

end