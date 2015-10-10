%% Runs the facerecognition code
addpath('../../common')
 
%% ORL Dataset
image_dir = uigetdir();

tic;
% Setting up the training imageset
X = getSet1Images(image_dir, 1, 35, 1, 5);
% Setting up the test imageset
Y = getSet1Images(image_dir, 1, 35, 6, 10);
toc;

ks = [1, 2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];

tic;
rs = zeros(size(ks));

for k = 1:numel(ks)
    rs(1, k) = myFaceRecognition(X, Y, 1, ks(1, k), 5, 5);
end
toc;

figure;
plot(ks, rs, '-o');
title('Graph of Recognition Rate vs k (ORL Dataset)');
xlabel('k');
ylabel('Recognition Rate');
grid on;
grid minor;

%% Yale Face Dataset

image_dir = uigetdir();

tic;
% Setting up the second training imageset
[X, Y] = getSet2Images(image_dir);
toc;

rs = zeros(size(ks));

tic;
wb = waitbar(0, 'Yale Dataset Face Recognition');
for k = 1:numel(ks)
    tic;
    rs(1, k) = myFaceRecognition(X, Y, 1, ks(1, k), 5, 5);
    toc;
    waitbar(k/numel(ks))
end
toc;
close(wb);

figure;
plot(ks, rs, '-o');
title('Graph of Recognition Rate vs k (Yale Dataset)');
xlabel('k');
ylabel('Recognition Rate');
grid on;
grid minor;
