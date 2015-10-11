function [rejected, correct_count, false_positives, false_negatives] = myForceFaceRecognition(X, Y, YStart, kmin, k, dpu, tpu, threshold)
    %% Function Doc
    % X - training dataset
    % Y - testing set
    % k - number of eigen values
    % dpu - training data images per user
    % tpu - testing data images per user

    %% Training Phase
    
    % Using the faster mode of PCA, computing the C
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
    
    % Find the closest dataset point for each point in the testset
    closest_indices = dsearchn(Xp', Yp');
    
    size_Xp = size(Xp);
    pixels = size_Xp(1, 1);
    rejected = 0;
    correct_count = 0;
    false_positives = 0;
    false_negatives = 0;
    
    for i = 1:num_test_images
        closest_match = Xp(:, closest_indices(i, 1));
        Y_column = Yp(:, i);
        difference = Y_column - closest_match;
        square_of_difference = difference.^2;
        distance = sqrt(sum(square_of_difference(:))/pixels);
        if (distance > threshold)
            rejected = rejected + 1;
            predicted_user = idivide(int32(closest_indices(i, 1) - 1),...
                int32(dpu), 'floor') + 1;
            actual_user = idivide(int32(i - 1),...
                int32(tpu), 'floor') + YStart;
            if predicted_user == actual_user
                false_negatives = false_negatives + 1;
            end
        else
            predicted_user = idivide(int32(closest_indices(i, 1) - 1),...
                int32(dpu), 'floor') + 1;
            actual_user = idivide(int32(i - 1),...
                int32(tpu), 'floor') + YStart;
            if predicted_user == actual_user
                correct_count = correct_count + 1;
            else
                false_positives = false_positives + 1;
            end
        end 
    end
    
end