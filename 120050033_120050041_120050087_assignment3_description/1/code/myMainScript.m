%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
[rows, cols] = size(imageOrig);

noisy_image = myGaussianNoiser(imageOrig, 0.10);
filtered_image = myButterworthFiltering(noisy_image, 75, 2);

images = zeros(rows, cols, 3);
images(:, :, 1) = imageOrig;
images(:, :, 2) = noisy_image;
images(:, :, 3) = filtered_image;

myShowImages(images, 'Butterworth Smoothened Boat');

toc;
