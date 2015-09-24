function colorCount = getUniqueColors(rgbImage)
    colors = containers.Map;
    [rows, cols, dim] = size(rgbImage);
    for i=1:rows
        for j=1:cols
            pixel = [rgbImage(i,j,1), rgbImage(i,j,2), rgbImage(i,j,3)];
            pixel = mat2str(pixel);
            if colors.isKey(pixel)
                colors(pixel) = colors(pixel) + 1;
            else
                colors(pixel) = 1;
            end
        end
    end
    colorCount = keys(colors);
end