%% MyMainScript

tic;
%% Your code here
barbara_filename = '../data/barbara.png';
canyon_filename = '../data/canyon.png';
tem_filename = '../data/tem.png';

barbara = imread(barbara_filename);
canyon = imread(canyon_filename);
canyon_r = canyon(:,:,1);
canyon_g = canyon(:,:,2);
canyon_b = canyon(:,:,3);
tem = imread(tem_filename);

barbara_linear = myLinearContrastStretching(barbara);

canyon_r_he = myHE(canyon_r);
canyon_g_he = myHE(canyon_g);
canyon_b_he = myHE(canyon_b);
canyon_he = cat(3, canyon_r_he, canyon_g_he, canyon_b_he);

tem_ahe = myAHE(tem, 20);
tem_clahe = myCLAHE(tem, 20, 0.5);

toc;
