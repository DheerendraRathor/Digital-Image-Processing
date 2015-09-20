%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
[rows, cols] = size(imageOrig);

noisy_image = myGaussianNoiser(imageOrig, 0.10);

D0 = 97;
filtered_image = myButterworthFiltering(noisy_image, D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(rmsd);

filtered_image = myButterworthFiltering(noisy_image, 0.95*D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(rmsd);

filtered_image = myButterworthFiltering(noisy_image, 1.05*D0, 2);
rmsd = myRMSDofImage(imageOrig, filtered_image);
display(rmsd);

images = zeros(rows, cols, 3);
images(:, :, 1) = imageOrig;
images(:, :, 2) = noisy_image;
images(:, :, 3) = filtered_image;

myShowImages(images, 'Butterworth Smoothened Boat');

toc;
