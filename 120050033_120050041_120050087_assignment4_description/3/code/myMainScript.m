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
% Observing the reconstructed face of the person shows that only a small
% number of k are enough to reconstruct the image and hence we can only use
% a small number of k to do it. The quality of reconstruction is bad
% initially and quickly becomes good. And after a certain k, the change in 
% quality of reconstruction becomes non-visible. This is also proven by the 
% data we see in the previous question which shows the recognition rate 
% becomes steady post a certain k
%
% The eigen faces are a unique thing about this algorithm which is that the 
% visualisations of the eigen vectors resembles an amalgamation of the
% images of the dataset. Also as the eigen value decreases we see a more
% noisy and eigen face with more artifacts. This is also visible in the
% fourier domain which shows a higher spread in the frequencies and hence
% indicating less of a significance towards a particular formation
