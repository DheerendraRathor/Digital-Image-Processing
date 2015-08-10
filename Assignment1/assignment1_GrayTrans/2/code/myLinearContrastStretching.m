function out_image = myLinearContrastStretching(filename, out_filename)
image = imread(filename);
minimum = double(min(min(image)));
maximum = double(max(max(image)));
out_image = image;

if (minimum < maximum)
    p = 255 / (maximum - minimum);
    q = - 255 * minimum / (maximum - minimum);
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            out_image(i, j) = p * double(image(i, j)) + q;
        end
    end
end

%imshow(uint8(out_image));
imwrite(uint8(out_image), out_filename);
end