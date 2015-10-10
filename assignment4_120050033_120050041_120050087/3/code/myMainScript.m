addpath('../../common/');

image_dir = uigetdir();

tic;

X = dheeruSet1Images(image_dir, 1, 40, 1, 10);

[Y, Sa, Sb] = dheeruSet1Images(image_dir, 15, 15, 3, 3);

ks = [2, 10, 20, 50, 75, 100, 125, 150, 175];

for k=1:numel(ks)
    [Vn, image] = plotEigenfaces(X, Y, 1, ks(1,k), Sa, Sb);
    subplot(3, 3, k);
    imagesc(image);
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf('k=%d', ks(1,k)));
end

[Vn, image] = plotEigenfaces(X, Y, 1, 25, Sa, Sb);

figure('units','normalized','outerposition',[0 0 1 1]);
for i = 1:25
    Vn_column = Vn(:, i);
    subplot(5, 5, i);
    imagesc(reshape(Vn_column, Sa, Sb));
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf('ev: %d', i));
end

figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:25
    Vn_column = Vn(:, i);
    eigenface = reshape(Vn_column, Sa, Sb);
    eigenface = fft2(eigenface);
    eigenface = fftshift(eigenface);
    eigenface = abs(eigenface);
    subplot(5, 5, i);
    imagesc(reshape(eigenface, Sa, Sb));
    daspect([1 1 1]);
    axis tight;
    colormap gray;
    title(sprintf('fourier: %d', i));
end

toc;

