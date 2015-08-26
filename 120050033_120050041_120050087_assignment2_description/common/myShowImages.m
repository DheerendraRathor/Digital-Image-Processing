function myShowImages(images)
    count = size(images, 3);
    
    for i = 1:count
        subplot(1, count, i);
        imshow(uint8(images(:,:,i)));
    end
end