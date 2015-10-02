%% Runs the facerecognition code
addpath('../../common')
 
%% ORL Dataset
image_dir = uigetdir();

tic;
% Setting up the training imageset
X = getSet1Images(image_dir, 1, 35, 1, 5);
% Setting up the test imageset
Y = getSet1Images(image_dir, 1, 35, 6, 10);

% Performing the PCA algorithm
myFaceRecognition(X, Y, 1, 100, 5, 5);
toc;

%% Yale Face Dataset

image_dir = uigetdir();

tic;
% Setting up the second training imageset
[X, Y] = getSet2Images(image_dir);

% Performing the PCA algorithm
myFaceRecognition(X, Y, 1, 100, 5, 5);
toc;