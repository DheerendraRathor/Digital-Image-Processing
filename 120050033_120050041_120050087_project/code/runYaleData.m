function [R_fisher, R_eigen_1, R_eigen_4, ks] = runYaleData()
    %% Loading the Yale Dataset
    training_size_per_user = 30;
    test_size_per_user = 30;
    folder = '../dataset/CachedYale/';
    ks = [1, 10, 25, 50, 100, 150, 250, 350, 500];

    [X, Y, C] = getYaleImages(training_size_per_user, test_size_per_user);
    [R_fisher, R_eigen_1, R_eigen_4] = runDataset(X, Y, C, training_size_per_user, test_size_per_user, folder, ks);
end