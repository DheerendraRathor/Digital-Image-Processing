function out_image = myHE(image)

[rows, cols] = size(image);

pd_values = pdf(image, 1, rows, 1, cols);
cd_values = cumsum(pd_values);

out_image = zeros(size(image, 1), size(image, 2));

for i = 1:rows
    for j = 1:cols
        out_image(i,j) = cd_values(image(i,j)+1)*255;
    end
end

out_image = uint8(out_image);

end