%% Mini Face Recognition Algorithm

%% Initial Setup 
addpath('../../common')

%% ORL Dataset
image_dir = uigetdir();

% Setting up the training imageset
X = getSet1Images(image_dir, 1, 35, 1, 5);
% Setting up the test imageset
Y = getSet1Images(image_dir, 1, 35, 6, 10);

ks = [1, 2, 3, 5, 10, 20, 30, 50, 75, 100, 125, 150, 170];

rs = zeros(size(ks));

% Running face recognition on ORL dataset
tic;
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
ks = [1, 2, 3, 5, 10, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];

% Setting up the Yale training imageset
[X, Y, dpu, tpu] = getSet2Images(image_dir);

rs = zeros(size(ks));

tic;
wb = waitbar(0, 'Yale Dataset Face Recognition');
for k = 1:numel(ks)
    rs(1, k) = myFaceRecognition(X, Y, 4, ks(1, k), dpu, tpu);
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
