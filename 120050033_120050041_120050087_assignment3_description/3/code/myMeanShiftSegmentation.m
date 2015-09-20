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
    
%     wb = waitbar(0, 'Mean shift segementation happening');
%     tic;
%     
%     for i = rmin:rmax
%         for j=cmin:cmax
%         
%             current_pixel = paddedImage(i, j, :);
%             windows_image = myGetExactWindowRGB(paddedImage, [i, j],...
%                 window);
%             prev_mean = cat(3, 0, 0, 0);
%             while true
%                 new_mean = getMean(windows_image, current_pixel, radius);
%                 are_close = arePixelsCloseEnough(prev_mean, new_mean,...
%                     epsilon);
%                 if are_close == true
%                     prev_mean = new_mean;
%                     break
%                 end
%                 prev_mean = new_mean;
%             end
%             
%             final_image(i, j, :) = prev_mean;
%             
%         end
%         waitbar(i/rows);
%     end
%     close(wb);
%     toc;
    final_image = final_image(rmin:rmax, cmin:cmax, :);
end
