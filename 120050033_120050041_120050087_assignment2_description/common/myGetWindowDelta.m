function [above, below, left, right] = myGetWindowDelta(image, point, window)
    [rows, cols] = size(image);
    
    i = point(1,1);
    j = point(1,2);
    
    rsz = floor(window(1,1)/2);
    csz = floor(window(1,2)/2);
    
    above = max([1, i - rsz]) - (i - rsz);
    below = (i + rsz) - min([i + rsz, rows]);
    left = max([1, j - csz]) - (j - csz);
    right = (j + csz) - min([j + csz, cols]);
    
end