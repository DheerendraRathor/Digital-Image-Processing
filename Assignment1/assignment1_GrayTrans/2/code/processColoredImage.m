function out_image = processColoredImage(image, functionHandle)
    image_r = image(:,:,1);
    image_g = image(:,:,2);
    image_b = image(:,:,3);
    processed_image_r = functionHandle(image_r);
    processed_image_g = functionHandle(image_g);
    processed_image_b = functionHandle(image_b);
    out_image = cat(3, processed_image_r, processed_image_g, processed_image_b);
%     p = gcp();
%     for idx = 1:3
%         f(idx) = parfeval(p, @(img) functionHandle(img), 1, image(:,:,1));
%     end
%     result = cell(1,3);
%     display(f);
%     for idx = 1:3
%         [completedIndex, result] = fetchNext(f);
%         result{completedIndex} = result;
%     end
%     out_image = cat(3, result{1}, result{2}, result{3});
end