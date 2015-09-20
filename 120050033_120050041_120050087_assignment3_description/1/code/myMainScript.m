%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
[rows, cols] = size(imageOrig);

display(myFourierEnergyRadii(imageOrig, 2));
toc;
