function W = getFisherFacePM(X, n, c, t)
    %% Get Fisher Face Projection Matrix
    % Returns the fisher face based face recognition weight matrix
    
    % X - training dataset
    % n - number of images
    % c - the number of users (classes in recognition)
    % t - training set size per user

    %% Training Phase
    
    mat_file = '../dataset/CachedYale/fisher_pm.mat';
    if exist(mat_file, 'file')
        load(mat_file, 'W');
        return
    end
    
    %% Computation
    % Fetch the W_pca
    Wpca = getPca(X, 1, n - c);
           
    Xpca = Wpca' * X;
    % Necessary dimensionality reduction for Sb, Sc calculation
    reduced_dimenionality = size(Xpca, 1);
     
    % Between-class scatter matrix
    Sb = zeros(reduced_dimenionality, reduced_dimenionality);
    
    % Within-class scatter matrix
    Sw = zeros(reduced_dimenionality, reduced_dimenionality);
    
    u = mean(Xpca, 2);
    for class = 1:c
        start_pos = (class - 1) * t + 1;
        end_pos = class * t;
                      
        Xi = Xpca(:, start_pos:end_pos);
        ui = mean(Xi, 2);
        Sb = Sb + (t * (ui - u) * ((ui - u)'));
        for image_pos = start_pos:end_pos
            xk = Xpca(:, image_pos);
            Sw = Sw + (xk - ui) * ((xk - ui)');
        end
    end
        
    % Get the generalised eigen vector
    % Only the first c-1 eigen vectors corresponding
    % to the non-zero eigen value
    [Wfld, ~] = eigs(Sb, Sw, c-1);
    
    % Calculate Wopt' = Wfld' * Wpca'
    W = real(Wpca * Wfld);
    
    save(mat_file, 'W');
end