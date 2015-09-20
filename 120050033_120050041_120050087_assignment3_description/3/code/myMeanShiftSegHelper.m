function final_image = myMeanShiftSegHelper(paddedImage, epsilon, window,...
    radius, iteration_count, iterations, rmin, rmax, cmin, cmax, rows)

    final_image = paddedImage;
    wb = waitbar(0, sprintf('Mean shift segementation. Iteration: %d/%d', iteration_count, iterations));
    
    tic;
    
    for i = rmin:rmax
        for j=cmin:cmax
        
            current_pixel = paddedImage(i, j, :);
            windows_image = myGetExactWindowRGB(paddedImage, [i, j],...
                window);
            prev_mean = cat(3, 0, 0, 0);
             while true
                new_mean = getMean(windows_image, current_pixel, radius);
                 are_close = arePixelsCloseEnough(prev_mean, new_mean,...
                     epsilon);
                 if are_close == true
                     prev_mean = new_mean;
                     break
                 end
                prev_mean = new_mean;
             end
            
            final_image(i, j, :) = prev_mean;
            
        end
        waitbar(i/rows);
    end
    toc;
    close(wb);

end