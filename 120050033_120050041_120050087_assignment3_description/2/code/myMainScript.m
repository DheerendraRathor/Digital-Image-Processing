%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
gpu_image = imageOrig;

% harris_image = myHarrisCornerDetector(gpu_image, 20, [9, 9], 0.24);
harris_image = myHarrisCornerDetector(gpu_image, 20, [15, 15], 0.24);

toc;
