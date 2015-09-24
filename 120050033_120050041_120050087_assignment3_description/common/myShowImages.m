function myShowImages(images, image_title)
    count = size(images, 3);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    for i = 1:count
        sub = subplot(1, count, i);
        imagesc(uint8(images(:,:,i)));
        colormap(gray);
        daspect([1 1 1]);
        axis tight;
        original_size = get(sub, 'Position');
    end
    colorbar;
    set(sub, 'position', original_size);
    suptitle(image_title);
end