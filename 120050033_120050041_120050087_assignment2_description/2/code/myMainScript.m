%% Edge-preserving Smoothing using Bilateral Filtering
%
% *Objective*
% 
% * Adding gaussian noise in the image
% * Applying bilateral filter to smoothen out image
% * Minimize Root Mean Square Distance
%

%% Original Image

% Image is loaded in variable imageOrig
load '../data/barbara.mat'
imageOrig = myLinearContrastStretching(imageOrig);

%% Generating noise and smoothening image
% Window size: 9, sigmaD: 3, sigmaR: 9
[smooth_image, gaussian_mask] = myBilateralFiltering(imageOrig, 9, 3, 9);
[rows, cols] = size(imageOrig);

%%
% Gaussian Mask
show_images = zeros(rows, cols, 1);
show_images(:,:,1) = gaussian_mask;
myShowImages(show_images);

%% 
% Smoothen Image
show_images = zeros(rows, cols, 3);
show_images(:, :, 1) = imageOrig;
show_images(:, :, 2) = imageOrig + gaussian_mask;
show_images(:, :, 3) = smooth_image;
myShowImages(show_images);

