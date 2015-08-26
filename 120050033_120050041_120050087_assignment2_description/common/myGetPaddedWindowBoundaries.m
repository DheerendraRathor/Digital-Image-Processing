function [prmin, prmax, pcmin, pcmax, rmin, rmax, cmin, cmax] = myGetPaddedWindowBoundaries(image, point, window)
    [rows, cols] = size(image);
    i = point(1,1);
    j = point(1,2);
    
    rsz = floor(window(1,1)/2);
    csz = floor(window(1,2)/2);
    
    rmin = max([1, i - rsz]);
    rmax = min([i + rsz, rows]);
    cmin = max([1, j - csz]);    
    cmax = min([j + csz, cols]);
    
end