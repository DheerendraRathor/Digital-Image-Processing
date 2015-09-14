%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
corner_detected_image = myHarrisCornerDetector(imageOrig);

toc;
