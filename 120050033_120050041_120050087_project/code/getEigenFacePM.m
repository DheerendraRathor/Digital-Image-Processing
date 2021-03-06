function W = getEigenFacePM(X, kmin, k, folder)
    %% Get Eigen Projection Matrix
    % Returns the eigen face based face recognition weight matrix
    
    % X - training dataset
    % kmin - the minimum k value to start with 
    % k - number of eigen values
    
    %% Training Phase
    
     % caching code
     mat_file = strcat(folder, 'eigenface_pm_', ...
         int2str(kmin), '_', int2str(k), '.mat');
     if exist(mat_file, 'file')
         load(mat_file, 'W');
         return
     end
    
    % Normalizing these eigen vectors
     W = pca(X', 'NumComponents', kmin + k - 1);
     W = W(:, kmin: kmin + k - 1);

     save(mat_file, 'W');
end