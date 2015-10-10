addpath('../../common/');

image_dir = uigetdir();

tic;

X = getSet1Images(image_dir, 1, 35, 1, 8);

Y = getSet1Images(image_dir, 35, 40, 1, 10);

toc;