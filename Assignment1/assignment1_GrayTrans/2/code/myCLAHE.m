function out_image = myCLAHE(filename, n)
image = imread(filename);
out_image = adapthisteq(image,'NumTiles',[n, n],'ClipLimit',1);
imshow(out_image);
%display(out_image(1:5,1:5));
end