%% Harris Corner Detection

%% Initialization
addpath('../../common/');
load ../data/boat.mat;
[rows, cols] = size(imageOrig);

%% Original Image

images = zeros(rows, cols, 1);
images(:, :, 1) = imageOrig;
myShowImages(images, 'Original Image');

%% Harris corner detection
[harris, gx, gy, eigen_1_harris, eigen_2_harris, appended_image]...
    = myHarrisCornerDetector(imageOrig, 0.5, [21, 21], 0.005);

%% Derivatix along x (Ix)

images = zeros(rows, cols, 1);
images(:, :, 1) = gx;
myShowImages(images, 'Derivating along x (Ix)');

%% Derivatix along y (Iy)

images = zeros(rows, cols, 1);
images(:, :, 1) = gy;
myShowImages(images, 'Derivating along y (Iy)');

%% Small eigen values of structure tensor 

images = zeros(rows, cols, 1);
images(:, :, 1) = eigen_1_harris;
myShowImages(images, 'Small eigen values of structure tensor');

%% Big eigen values of structure tensor 

images = zeros(rows, cols, 1);
images(:, :, 1) = eigen_2_harris;
myShowImages(images, 'Big eigen values of structure tensor');

%% Harris Corner Measured image

images = zeros(rows, cols, 1);
images(:, :, 1) = harris;
myShowImages(images, 'Harris Corner Measured Image');

%% Darkened image overlapped with harris

imshow(appended_image, [0, 1]);