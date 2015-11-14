function W = getPca(X, kmin, k)
    %% Get Cached PCA
    % Returns the PCA of X
    
    % X - image dataset
    % kmin - the minimum k value to start with 
    % k - number of eigen values
    
    %% Calculate the PCA
    
    % Center the data
    mu = mean(X,2);
    M = X - repmat(mu, 1, size(X,2));
    
    % get the eigen vectors using SVD to prevent unbalanced error
    [U, ~, ~] = svd(M ,'econ');
    W = U(:, kmin:(kmin + k - 1));
end