%% PCA based image denoising
addpath('../../common/');

%% Initial Setup
image = imread('../data/barbara256.png');
image = double(image);
[rows, cols] = size(image);
standard_deviation = 20;
noisy_image = standard_deviation*randn(size(image)) + image;

rmsd_of_noisy_image = myRMSDofImage(image, noisy_image);
fprintf('RMSD of Noisy Image is: %.6f\n', rmsd_of_noisy_image);

%% Simple PCA Denoising

tic;
denoised_image = myPCADenoising1(noisy_image, [7, 7], standard_deviation);
denoised_image = reshape(denoised_image, rows, cols);
elapsed_time = toc;
if elapsed_time > 300
    save('../images/barbara_simple_pca.mat', 'denoised_image')
end

images = zeros(rows, cols, 3);
images(:, :, 1) = image;
images(:, :, 2) = noisy_image;
images(:, :, 3) = denoised_image;

myShowImages(images, 'Simple PCA Denoised Barbara');

fprintf('Time taken: %d\n', elapsed_time);
rmsd_of_denoised_image = myRMSDofImage(image, denoised_image);
fprintf('RMSD of Simple PCA denoised Image is: %.6f\n',...
    rmsd_of_denoised_image);

%% Better PCA Denoising
tic;
denoised_image = myPCADenoising2(noisy_image, [7, 7], [31, 31], 200,...
    standard_deviation);
denoised_image = reshape(denoised_image, rows, cols);
elapsed_time = toc;
if elapsed_time > 300
    save('../images/barbara_better_pca.mat', 'denoised_image')
end

images = zeros(rows, cols, 3);
images(:, :, 1) = image;
images(:, :, 2) = noisy_image;
images(:, :, 3) = denoised_image;

myShowImages(images, 'Better PCA Denoised Barbara');

fprintf('Time taken: %d\n', elapsed_time);
rmsd_of_denoised_image = myRMSDofImage(image, denoised_image);
fprintf('RMSD of Better PCA denoised Image is: %.6f\n',...
    rmsd_of_denoised_image);

%% Bilateral Filtering

tic;
denoised_image = myBilateralFiltering(noisy_image, [15, 15], 1, 51.25);
elapsed_time = toc;
if elapsed_time > 300
    save('../images/barbara_bilateral.mat', 'denoised_image')
end

images = zeros(rows, cols, 3);
images(:, :, 1) = image;
images(:, :, 2) = noisy_image;
images(:, :, 3) = denoised_image;

myShowImages(images, 'Bilateral filtering smoothened barbara');

fprintf('Time taken: %d\n', elapsed_time);
rmsd_of_denoised_image = myRMSDofImage(image, denoised_image);
fprintf('RMSD of bilateral filtered smoothened Image is: %.6f\n',...
    rmsd_of_denoised_image);