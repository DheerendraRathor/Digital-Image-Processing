%% Question 4
% Testing on images of people which were not part of training set
% Training on first 35 persons and testing on last 5 persons
% 
% *Mechanism:* By taking the difference of rmsd of closest matched projected
% Dataset. If the difference is greater then a theshold then image
% matching will be rejected
%
% Threshold of rmsd difference = 15
%

%% Initial setup
addpath('../../common/');

image_dir = uigetdir();

threshold = 18;

training_count = 35;
training_image_per_user = 5;
testing_start = 36;
testing_end = 40;
testing_image_per_user_start = 1;
testing_image_per_user_end = 10;

% Reading first 35 images for training
X = getSet1Images(image_dir, 1, training_count, 1,...
    training_image_per_user);

% Reading last 5 images for testing
Y = getSet1Images(image_dir, testing_start, testing_end,...
    testing_image_per_user_start, testing_image_per_user_end);

%% Testing on last 50 images
% Images for training = 35 * 5 
%
% Images for testing = 5 * 10  
%
[rejected, correct_count, false_positives, false_negatives] =...
    myForceFaceRecognition(X, Y, testing_start, 1, 25,...
    training_image_per_user,...
    testing_image_per_user_end - testing_image_per_user_start + 1,...
    threshold);

display(sprintf('False Positives: %d\nFalse Negatives: %d',...
    false_positives, false_negatives));
display(sprintf('Rejected Images: %d\nCorrect Identification Count: %d',...
    rejected, correct_count));

%% Testing on all 35 Users
% Images for training = 35 * 5  
%
% Images for testing = 35 * 5 (bottom 5)  
%
testing_start = 1;
testing_end = 35;
testing_image_per_user_start = 6;
testing_image_per_user_end = 10;

X = getSet1Images(image_dir, 1, training_count, 1,...
    training_image_per_user);

Y = getSet1Images(image_dir, testing_start, testing_end,...
    testing_image_per_user_start, testing_image_per_user_end);

[rejected, correct_count, false_positives, false_negatives] =...
    myForceFaceRecognition(X, Y, testing_start, 1, 25,...
    training_image_per_user,...
    testing_image_per_user_end - testing_image_per_user_start + 1,...
    threshold);

display(sprintf('False Positives: %d\nFalse Negatives: %d',...
    false_positives, false_negatives));
display(sprintf('Rejected Images: %d\nCorrect Identification Count: %d',...
    rejected, correct_count));
