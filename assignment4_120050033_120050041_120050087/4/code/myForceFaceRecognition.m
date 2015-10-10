function R = myForceFaceRecognition(X, Y, YStart, kmin, k, dpu, tpu)
    %% Function Doc
    % X - training dataset
    % Y - testing set
    % k - number of eigen values
    % dpu - training data images per user
    % tpu - testing data images per user

    %% Training Phase
    
    % Using the faster mode of PCA, computing the C
    tic;
    C = X' * X;
    
    % Computing the k max eigen values, vector of the covariance matrix
    [Evec, Eval] = eigs(C, kmin + k - 1);
    
    % Computing the original eigen vectors
    V = X * Evec(:, kmin:(kmin + k - 1));
    
    % Normalizing these eigen vectors
    Vn = normc(V);
    
    % project the dataset
    Xp = projectDataset(X, Vn);
    toc;
    
    %% Testing Phase
    
    % Number of test images
    num_test_images = size(Y, 2);
   
    % Project to reduced eigen space of dataset and normalise
    Yp = projectDataset(Y, Vn);
    
    % Find the closest dataset point for each point in the testset
    closest_indices = dsearchn(Xp', Yp');
    
    size_Xp = size(Xp);
    pixels = size_Xp(1, 1);
    
    for i = 1:num_test_images
        closest_match = Xp(:, closest_indices(i, 1));
        Y_column = Yp(:, i);
        difference = Y_column - closest_match;
        square_of_difference = difference.^2;
        distance = sqrt(sum(square_of_difference(:))/pixels);
    end
    
    % Iteratign over  the closest indices to find recognition rate
    predicted_users = idivide(int32(closest_indices' - 1), int32(dpu), 'floor') + 1;
    actual_users = idivide(int32([1:num_test_images] -1), int32(tpu), 'floor') + 1 + YStart;
    differences = predicted_users - actual_users;
    correct_count = sum(differences(:)==0);
    
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