function bilateral_image = myBilateralFiltering(image)
    [row, col] = size(image);
    bilateral_image = zeros(row, col);
    
    for i = 1:row
        for j = 1:col
            % pixel i,j
            for k = 1:row
                for l = 1:col
                    
                    
end