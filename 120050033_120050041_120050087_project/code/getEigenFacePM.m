function W = getEigenFacePM(X, kmin, k)
    %% Get Eigen Projection Matrix
    % Returns the eigen face based face recognition weight matrix
    
    % X - training dataset
    % kmin - the minimum k value to start with 
    % k - number of eigen values

    %% Training Phase
    
     % caching code
     mat_file = strcat('../dataset/CachedYale/', 'eigenface_pm_', ...
         int2str(kmin), '_', int2str(k), '.mat');
     if exist(mat_file, 'file')
         load(mat_file, 'W');
         return
     end
    
    % Normalizing these eigen vectors
     W = getPca(X, kmin, k);

     save(mat_file, 'W');
end