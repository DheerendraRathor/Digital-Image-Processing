function colormap = getColormapForRGBImage(image)
    [ind, colormap] = rgb2ind(image, 256);
end