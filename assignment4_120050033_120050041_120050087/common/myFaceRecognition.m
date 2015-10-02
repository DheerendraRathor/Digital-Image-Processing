function R = myFaceRecognition(X, Y, kmin, k, dpu, tpu)
    %% Function Doc
    % X - training dataset
    % Y - testing set
    % k - number of eigen values
    % dpu - training data images per user
    % tpu - testign data images per user

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
    Xp = projectDataset(X, Vn);
    
    %% Testing Phase
    
    % Number of test images
    num_test_images = size(Y, 2);
   
    % Project to reduced eigen space of dataset and normalise
    Yp = projectDataset(Y, Vn);
    
    % Find the closest dataset point for each point in the testset
    closest_indices = dsearchn(Xp', Yp');
    
    % Iteratign over  the closest indices to find recognition rate
    correct_count = 0;
    for i =  1:num_test_images
        predicted_user = getUserId(closest_indices(i, 1), dpu);
        actual_user = getUserId(i, tpu);
        if eq(predicted_user, actual_user)
            correct_count = correct_count + 1;
        end
    end
    
    % Recognition Rate
    R = correct_count / num_test_images;
    display(R);
end

function user = getUserId(index, ipu)
% Finds the user index given the image index and the images per user
    user = idivide(int32(index-1), int32(ipu), 'floor') + 1;
end

function P = projectDataset(X, V)
% Projects the dataset X on the vectors V
    [dimension, cols] = size(X);
    vectors = size(V, 2);
    P = zeros(dimension, cols);
    for image_id = 1:cols
        projected = zeros(dimension, 1);
        for eigen_id = 1:vectors
            projected = projected + V(:, eigen_id)*dot(V(:, eigen_id), X(:, image_id));
        end
        P(:, image_id) = projected;
    end
end