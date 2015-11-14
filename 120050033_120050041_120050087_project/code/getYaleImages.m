function [X, Y, C] = getYaleImages(Xsize, Ysize)
    %% Function Doc
    
    % Xsize - training data images per user
    % Ysize - testing data images per user
    
    %% Load the Images
    
    % Setting up the Yale training imageset - Using file
    % saving/loading to speed up loading
    
    image_dir = '../dataset/CroppedYale/';
    mat_file = '../dataset/CachedYale/yale.mat';
    
    if exist(mat_file, 'file')
        load(mat_file, 'X', 'Y', 'C');
        return
    end
        
    X = [];
    Y = [];
    classes = 0;
       
    folders = dir(image_dir);
    % Looping over the folders, (first 2 are . ..)
    wb = waitbar(0, 'Compiling Images');    
    for folder = 1:size(folders, 1) 
        if regexp(folders(folder, 1).name, '^\.')
            continue
        end
        
        classes = classes + 1;
        % Creating the folder name
        folder_name = strcat(image_dir, '/', folders(folder, 1).name);
        
        % Getting the files in that folder
        files = dir(folder_name);
        file_count = 0;
        % Iterating over the first Xsize files, (first 2 are . ..)
        for file = 1:size(files, 1)
           if regexp(files(file, 1).name, '^\.')
                continue
           end
            % Creating the name of the file
            image_filename = strcat(folder_name, '/', files(file, 1).name);
            
            % Reading the file
            image = imread(image_filename);
            
            % Converting image to column
            image_col = reshape(image, [], 1);
               
            % This will give a warning saying its slow, however the image
            % reading step is the rate limiting step and even using the
            % standard way doesnt speed up anything. So, using this as this
            % is cleaner and easier to understand
            if file_count < Xsize
                X = [X image_col];
            elseif file_count < Xsize + Ysize
                Y = [Y image_col];
            end
            file_count = file_count + 1;
            waitbar((folder*size(files, 1) + file)/(size(files, 1)*size(folders, 1)));
        end
    end
    
    close(wb);
    
    % Converting image from  uint to double for later calculations
    X = double(X); 
    Y = double(Y);
    C = classes;
    
    save(mat_file, 'X', 'Y', 'C');
%     display('[Progress] Yale dataset load completed');
end