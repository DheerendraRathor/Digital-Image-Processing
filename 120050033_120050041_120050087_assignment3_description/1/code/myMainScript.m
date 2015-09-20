%% MyMainScript
% Fourier Analysis

%% Initialization
addpath('../../common/');
load '../data/boat.mat';
D0 = 97;
noisy_image = myGaussianNoiser(imageOrig, 0.10);
fourier = fft2(noisy_image);
fourier_shifted = fftshift(fourier);
[rows, cols] = size(imageOrig);

%% Butterworth filter

filter = myButterworthFilter(D0, 2, size(fourier_shifted));
threeD_filter = surf(filter);

images = zeros(rows, cols, 1);
images(:, :, 1) = filter;
myShowImages(images, 'Butterworth filter in frequency domain');

%% Images comparison

display(sprintf('Optimal D0 is %f', D0));

filtered_image = myButterworthFiltering(noisy_image, D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(sprintf('RMSD of filtered image with optimal D0 is %f', rmsd));

filtered_image = myButterworthFiltering(noisy_image, 0.95*D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(sprintf('RMSD of filtered image with 0.95*D0 is %f', rmsd));

filtered_image = myButterworthFiltering(noisy_image, 1.05*D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(sprintf('RMSD of filtered image with optimal 1.05*D0 is %f', rmsd));

images = zeros(rows, cols, 3);
images(:, :, 1) = imageOrig;
images(:, :, 2) = noisy_image;
images(:, :, 3) = filtered_image;

myShowImages(images, 'Butterworth Smoothened Boat');
