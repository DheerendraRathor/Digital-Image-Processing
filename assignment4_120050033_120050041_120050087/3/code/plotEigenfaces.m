function [Vn, image]  =  plotEigenfaces( X, Y, kmin, k, Sa, Sb)

    C = X' * X;
    
    % Computing the k max eigen values, vector of the covariance matrix
    [Evec, Eval] = eigs(C, kmin + k - 1);
    
    % Computing the original eigen vectors
    V = X * Evec(:, kmin:(kmin + k - 1));
    
    % Normalizing these eigen vectors
    Vn = normc(V);
    
    % project the dataset
    Xp = Vn*(Vn\X);
    
    %% Testing Phase
    
    % Number of test images
    num_test_images = size(Y, 2);
   
    % Project to reduced eigen space of dataset and normalise
    Yp = Vn*(Vn\Y);
    
    closest_indices = knnsearch(Xp', Yp');
    
    image = reshape(Xp(:, closest_indices(1, 1)), Sa, Sb); 


end
