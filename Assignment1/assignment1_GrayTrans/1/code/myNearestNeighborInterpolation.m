function out_image = myNearestNeighborInterpolation(filename, out_filename)
image = imread(filename);

M = size(image, 1);
N = size(image, 2);
final_M = 3*M - 2;
final_N = 2*N - 1;

out_image = zeros(final_M, final_N);

for i = 1:final_M
    for j = 1:final_N
        next_x = ceil((i+2)/3);
        prev_x = floor((i+2)/3);
        next_y = ceil((j+1)/2);
        prev_y = floor((j+1)/2);
        
        next_x_distance = (3*next_x - 2) - i;
        prev_x_distance = i - (3*prev_x - 2);
        next_y_distance = (2*next_y - 1) - j;
        prev_y_distance = j - (2*prev_y - 1);
        
        image_nx_ny = int32(image(next_x, next_y));
        image_nx_py = int32(image(next_x, prev_y));
        image_px_ny = int32(image(prev_x, next_y));
        image_px_py = int32(image(prev_x, prev_y));
        
        distance_nx_ny = next_x_distance^2 + next_y_distance^2;
        distance_nx_py = next_x_distance^2 + prev_y_distance^2;
        distance_px_ny = prev_x_distance^2 + next_y_distance^2;
        distance_px_py = prev_x_distance^2 + prev_y_distance^2;
        
        smallest_distance = min([distance_nx_ny, distance_nx_py, distance_px_ny, distance_px_py]);
        
        if (smallest_distance == distance_nx_ny)
            out_image(i,j) = image_nx_ny;
        elseif (smallest_distance == distance_nx_py)
            out_image(i,j) = image_nx_py;
        elseif (smallest_distance == distance_px_ny)
            out_image(i,j) = image_px_ny;
        elseif (smallest_distance == distance_px_py)
            out_image(i,j) = image_px_py;
        end
    end
end

%imshow(uint8(out_image));
imwrite(uint8(out_image), out_filename);
end