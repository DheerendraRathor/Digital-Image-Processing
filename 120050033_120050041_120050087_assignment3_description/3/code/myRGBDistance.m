function [ distance ] = myRGBDistance(pixel1, pixel2)
    
    distance = sqrt(sum((pixel1 - pixel2).^2));

end

