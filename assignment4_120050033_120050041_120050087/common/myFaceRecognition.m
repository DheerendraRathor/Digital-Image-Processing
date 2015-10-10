function R = myFaceRecognition(X, Y, kmin, k, dpu, tpu)
    %% Function Doc
    % X - training dataset
    % Y - testing set
    % k - number of eigen values
    % dpu - training data images per user
    % tpu - testign data images per user

    %% Training Phase
    display('Starting');
    
    tic;
    % Using the faster mode of PCA, computing the C
    C = X' * X;
    toc;

    % Computing the k max eigen values, vector of the covariance matrix
    [Evec, Eval] = eigs(C, kmin + k - 1);

    % Computing the original eigen vectors
    V = X * Evec(:, kmin:(kmin + k - 1));

    % Normalizing these eigen vectors
    Vn = normc(V);
    
    tic;
    % project the dataset
    Xp = Vn*(Vn\X); 
    toc;
    %% Testing Phase
    
    % Number of test images
    num_test_images = size(Y, 2);
    
    tic;
    % Project to reduced eigen space of dataset and normalise
    Yp = Vn*(Vn\Y);
    toc;
    
    tic;
    % Find the closest dataset point for each point in the testset
    closest_indices = knnsearch(Xp', Yp');
    toc;
    
    % Iteratign over  the closest indices to find recognition rate
    predicted_users = idivide(int32(closest_indices' - 1), int32(dpu), 'floor') + 1;
    actual_users = idivide(int32([1:num_test_images] -1), int32(tpu), 'floor') + 1;
    differences = predicted_users - actual_users;
    correct_count = sum(differences(:)==0);
    
    % Recognition Rate
    R = correct_count / num_test_images;
end