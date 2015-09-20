%% Mean Shift Image Segmentation
% Mean shift Image Segmentation

%%  Initialization
image = imread('../data/baboonColor.png');
small_image = imresize(image, 0.5);
[rows, cols] = size(small_image);

%% Image Segmentation
segmented_image = myMeanShiftSegmentation(small_image, [21 21], [15 25], 5, 0.01);

images = zeros(rows, cols, 2);
images(:, :, 1) = small_image;
images(:, :, 2) = segmented_image;

myShowImages(images, 'Segmented Images');

%% Parameters
display(sprintf('Kernel bandwidth for color feature %d', 25));
display(sprintf('Kernel bandwidth for spatial feature %d', 21));
display(sprintf('Number of iterations %d', 5));