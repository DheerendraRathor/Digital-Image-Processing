function out_image = myShrinkImageByFactorD(filename, out_filename, d)
image = imread(filename);
d = int32(d);

out_image = zeros(idivide(size(image,1),d), idivide(size(image,2),d));
for i = 1:size(image,1)
    for j = 1:size(image,2)
        if (and(eq(mod(i,d),0) , eq(mod(j,d), 0)))
            final_i = idivide(i,d);
            final_j = idivide(j,d);
            out_image(final_i, final_j) = image(i,j);
            %display([out_image(final_i, final_j), image(i,j)])
        end
    end
end

%imshow(uint8(out_image));
imwrite(uint8(out_image), out_filename);
end