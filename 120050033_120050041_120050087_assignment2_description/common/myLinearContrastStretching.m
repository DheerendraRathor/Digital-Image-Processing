function out_image = myLinearContrastStretching(image)

minimum = double(min(image(:)));
maximum = double(max(image(:)));
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

end