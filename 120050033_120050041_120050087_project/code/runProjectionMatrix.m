function R = runProjectionMatrix(X, Y, W, training_per_user, test_per_user)
    %% Run Projection Matrix
    % Runs the projections matrix W on X and Y and tries to compute the
    % percentage of correctness
    
    % X - training dataset
    % Y - testing dataset
    % W - projection matrix
    % training_per_user - training data images per user
    % test_per_user - testign data images per user
    
    %% Testing Phase
           
    % Project the dataset
    Xp = W' * X;
    
    % Number of test images
    num_test_images = size(Y, 2);
    
    % Project to reduced eigen space of dataset and normalise
    Yp = W' * Y;
    
    % Find the closest dataset point for each point in the testset
    closest_indices = knnsearch(Xp', Yp');
    
    % Iterating over the closest indices to find recognition rate
    predicted_users = idivide(int32(closest_indices' - 1), ...
        int32(training_per_user), 'floor') + 1;
    actual_users = idivide(int32([1:num_test_images] -1), ...
        int32(test_per_user), 'floor') + 1;
    differences = predicted_users - actual_users;
    correct_count = sum(differences(:)==0);
    
    % Recognition Rate
    R = correct_count / num_test_images;
end