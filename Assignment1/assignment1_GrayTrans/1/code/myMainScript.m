%% MyMainScript

tic;
%% Your code here
barbara_filename = '../data/barbaraSmall.png';
circles_filename = '../data/circles_concentric.png';

barbara = imread(barbara_filename);
circles = imread(circles_filename);

shrink_by_2 = myShrinkImageByFactorD(circles, 2);
shrink_by_3 = myShrinkImageByFactorD(circles, 3);

bilinear_interpolation = myBilinearInterpolation(barbara);
nearest_neighbour_interpolation = myNearestNeighborInterpolation(barbara);

toc;
