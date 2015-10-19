%% MyMainScript
addpath('../../common/');
tic;
%% Your code here
% image = imread('../data/barbara256.png');
% [rows, cols] = size(image);
% standard_deviation = 20;
% 
% noisy_image = standard_deviation*randn(size(image)) + double(image);
% denoised_image = myPCADenoising1(noisy_image, [7, 7], standard_deviation);
% denoised_image = reshape(denoised_image, rows, cols);
% 
% images = zeros(rows, cols, 3);
% images(:, :, 1) = image;
% images(:, :, 2) = noisy_image;
% images(:, :, 3) = denoised_image;
% 
% myShowImages(images, 'Simple PCA Denoised Barbara');
% 
%% Your code here
image = imread('../data/barbara256.png');
image = image(1:128, 1:128);
[rows, cols] = size(image);
standard_deviation = 20;

noisy_image = standard_deviation*randn(size(image)) + double(image);
denoised_image = myPCADenoising2(noisy_image, [7, 7], [31, 31], 200, standard_deviation);
denoised_image = reshape(denoised_image, rows, cols);

images = zeros(rows, cols, 3);
images(:, :, 1) = image;
images(:, :, 2) = noisy_image;
images(:, :, 3) = denoised_image;

myShowImages(images, 'Better PCA Denoised Barbara');

toc;
