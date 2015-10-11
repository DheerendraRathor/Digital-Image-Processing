function [X, Y, Xsize, Ysize] = getSet2Images(image_dir)
    X = [];
    Y = [];
    
    folders = dir(image_dir);
    % Looping over the folders, (first 2 are . ..)
    wb = waitbar(0, 'Compiling Images');
    for folder = 1:size(folders, 1) 
        if regexp(folders(folder, 1).name, '^\.')
            continue
        end
        
        % Creating the folder name
        folder_name = strcat(image_dir, '/', folders(folder, 1).name);
        
        % Getting the files in that folder
        files = dir(folder_name);
        file_count = 0;
        % Iterating over the first 30 files, (first 2 are . ..)
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
            if file_count < 30
                X = [X image_col];
            elseif file_count < 60
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
    Xsize = 30;
    Ysize = 30;
end