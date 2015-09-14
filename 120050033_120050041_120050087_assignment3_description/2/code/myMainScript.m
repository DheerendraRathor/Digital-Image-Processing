%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
%gpu_image = gpuArray(imageOrig);
gpu_image = imageOrig;
corner_detected_image = myHarrisCornerDetector(gpu_image, 50, [55, 55], 0.4);

toc;
