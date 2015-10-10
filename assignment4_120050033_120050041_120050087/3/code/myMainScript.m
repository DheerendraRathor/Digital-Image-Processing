addpath('../../common/');

image_dir = uigetdir();

tic;

X = dheeruSet1Images(image_dir, 1, 40, 1, 10);

[Y, Sa, Sb] = dheeruSet1Images(image_dir, 1, 1, 1, 1);

toc;

