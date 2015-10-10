function [X, Y] = getSet2Images(image_dir)
    X = [];
    Y = [];
    
    folders = dir(image_dir);
    % Looping over the folders, (first 2 are . ..)
    wb = waitbar(0, 'Compiling Images');
    for folder = 3:size(folders, 1)        
        % Creating the folder name
        folder_name = strcat(image_dir, '/', folders(folder, 1).name);
        
        % Getting the files in that folder
        files = dir(folder_name);
        
        % Iterating over the first 30 files, (first 2 are . ..)
        for file = 3:size(files, 1)
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
            if file <= 32
                X = [X image_col];
            else
                Y = [Y image_col];
            end
            
            waitbar(((folder-3)*60 + file - 2)/(38*60));
        end
    end
    
    close(wb);
    
    % Converting image from  uint to double for later calculations
    X = double(X); 
    Y = double(Y);
    
    size(X)
    size(Y)
end