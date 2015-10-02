%% Runs the facerecognition code
tic;
% Setting up the training imageset
X = getSet1Images(1, 35, 1, 5);

% Setting up the test imageset
Y = getSet1Images(1, 35, 6, 10);
toc;

tic;
% Performing the PCA algorithm
myFaceRecognition(X, Y, 100, 5, 5);
toc;