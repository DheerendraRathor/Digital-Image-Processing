function X = getSet1Images(person_start, person_end, image_start, image_end)
    X = [];
    
    % Looping over the people
    for person = person_start:person_end
        % Creating the directory name
        dir = strcat('../dataset/s', num2str(person),'/');
        
        % Looping over the image of that person
        for image_id = image_start:image_end
            % Creating the name of the file
            image_filename = strcat(dir, num2str(image_id),'.pgm');
            
            % Reading the file
            image = imread(image_filename);
            
            % Converting image to column
            image_col = reshape(image, [], 1);
               
            % This will give a warning saying its slow, however the image
            % reading step is the rate limiting step and even using the
            % standard way doesnt speed up anything. So, using this as this
            % is cleaner and easier to understand
            X = [X image_col];
        end
    end
    
    % Converting image from  uint to double for later calculations
    X = double(X); 
end