function windowed_image = myGetWindow(image, point, window_size)
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, window_size);
    windowed_image = image(rmin:rmax, cmin:cmax);
end