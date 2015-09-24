function [final_image] = myMeanShiftSegmentation(image, window, radius, iterations, epsilon)
    addpath('../../common/');
    [rows, cols, dim] = size(image);
    
%     myfilter = fspecial('gaussian',[9 9], 1);
%     myfilteredimage = imfilter(image, myfilter, 'replicate');
    myfilteredimage = image;
    
    rPaddedImage = myPaddedImage(myfilteredimage(:, :, 1), window);
    bPaddedImage = myPaddedImage(myfilteredimage(:, :, 2), window);
    [gPaddedImage, rmin, rmax, cmin, cmax] = myPaddedImage(...
        myfilteredimage(:, :, 3), window);
    
    paddedImage = cat(3, rPaddedImage, bPaddedImage, gPaddedImage);
    final_image = paddedImage;
    
    for i=1:iterations
        final_image = myMeanShiftSegHelper(final_image, epsilon,...
            window, radius, i, iterations, rmin, rmax, cmin, cmax, rows);
    end
    
    final_image = final_image(rmin:rmax, cmin:cmax, :);
end
