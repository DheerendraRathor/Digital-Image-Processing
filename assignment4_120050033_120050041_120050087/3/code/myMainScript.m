%% Question 3

%% Initial Setup
addpath('../../common/');
image_dir = uigetdir();

% Reading all images from image_dir
X = getSet1ImagesWithSize(image_dir, 1, 40, 1, 10);

% Reading image (15, 3) from image_dir
[Y, Sa, Sb] = getSet1ImagesWithSize(image_dir, 15, 15, 3, 3);

ks = [2, 10, 20, 50, 75, 100, 125, 150, 175];

%% Reconstructed Image
figure('units','normalized','outerposition',[0 0 1 1]);
for k=1:numel(ks)
    [Vn, image] = plotEigenfaces(X, Y, 1, ks(1,k), Sa, Sb);
    subplot(3, 3, k);
    imagesc(image);
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf(' Reconstructed image. k=%d', ks(1,k)));
end

%% Displaying Eigenfaces corresponding to largest 25 eigenvalues
[Vn, image] = plotEigenfaces(X, Y, 1, 25, Sa, Sb);

figure('units','normalized','outerposition',[0 0 1 1]);
for i = 1:25
    Vn_column = Vn(:, i);
    subplot(5, 5, i);
    imagesc(reshape(Vn_column, Sa, Sb));
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf('Eigenvector: %d', i));
end

%% Fourier of 25 eigenfaces on log scale
figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:25
    Vn_column = Vn(:, i);
    eigenface = reshape(Vn_column, Sa, Sb);
    eigenface = fft2(eigenface);
    eigenface = fftshift(eigenface);
    eigenface = abs(eigenface);
    eigenface = log(eigenface + 1);
    
    subplot(5, 5, i);
    imagesc(reshape(eigenface, Sa, Sb));
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf('fourier of eigenvector: %d', i));
end

%% Observation
% Nishant karega ye
