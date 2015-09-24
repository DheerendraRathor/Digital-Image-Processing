%% Mean Shift Image Segmentation
% Mean shift Image Segmentation

%%  Initialization
image = imread('../data/baboonColor.png');
small_image = imresize(image, 0.5);
[rows, cols, dim] = size(small_image);
iterations = 10;

%% Image Segmentation
tic;
segmented_image = myMeanShiftSegmentation(small_image, [21 21], [15 25],...
    iterations, 0.01);
elapsed_time = toc;

if elapsed_time > 300
    save('../images/segmented_image.mat', 'segmented_image');
end

images = zeros(rows, cols, dim, 2);
images(:, :, :, 1) = small_image;
images(:, :, :, 2) = segmented_image;

myShowImagesRGB(images, 'Segmented Images');

%% Parameters
display(sprintf('Kernel bandwidth for color feature %d', 25));
display(sprintf('Kernel bandwidth for spatial feature %d', 21));
display(sprintf('Number of iterations %d', iterations));