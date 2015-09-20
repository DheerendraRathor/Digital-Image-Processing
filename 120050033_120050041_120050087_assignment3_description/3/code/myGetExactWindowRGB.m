function [ windowed_image ] = myGetExactWindowRGB(image, point, window_size)
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, window_size);
    windowed_image = image(rmin:rmin+window_size(1,1), cmin:cmin+window_size(1,2), :);
end

