function displayImageWithColorBar(image, image_title, color_scale, map)
% displayImageWithColorBar displays image with color bar 
%   *Arguments*:
%       * image: Image you is going to be displayed
%       * color_scale: Color scale for colormap
%       * map: colormap name ex. gray, jet
    imshow(image, []);
    axis on;
    title(image_title, 'FontSize', 10);
    os2 = get(gca, 'Position');
    colormap(color_scale);
    if nargin > 3
        colormap(map);
    end
    daspect([1 1 1]);
    colorbar;
    set(gca, 'position', os2);