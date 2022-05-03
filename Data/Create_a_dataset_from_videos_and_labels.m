%% Introduction
% This is an example showing how to create a dataset for training from 
% videos and label-files.


%% Preparations:
% 1. Create a folder called Data under C:
% 2. Copy the folders Video_IR and Video_V to the folder C:\Data
% 3. Add the folder C:\Data to the Matlab path using "Set Path"
% This has to be done so that the DataSource-value of the groundTruth-
% object in the label-file points at the correct video file.


%MANUALLY CREATE THE "Training_data_V" and "labels" folder next to this
%script!!! after running it, rename the "Training_data_V" to "images"

%%
% Specify the folder where the files live.
myFolder = 'C:\Data\Video_V\';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*LABELS.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);



    %% Load ground truth from four label-files
    gt1=load(fullFileName);


    %% Put the ground truth together
    gTruth = [gt1.gTruth];
    gTruth = selectLabels(gTruth,{'AIRPLANE','BIRD','DRONE','HELICOPTER'});

    %% Create a folder for all the images that will be extracted from the videos
    %if isfolder(fullfile('Training_data_V'))
    %    cd Training_data_V
    %else
    %    mkdir Training_data_V
    %end 
    %addpath('Training_data_V');
    width = 640;
    height = 512;


    %% Produce the training dataset
    trainingData = objectDetectorTrainingData(gTruth,...
        'SamplingFactor', [1], ...
        'WriteLocation','Training_data_V');
    % Using a sampling factor of 1 means that all images from the video will be
    % included in the dataset.
    % If more or less than four label-files is to be included, the length of the
    % SamplingFactor-array must also be changed so that the number of files and
    % the length are the same.


    %% Save the training dataset
    amount = size(trainingData.imageFilename);
    for i = 1:amount(1)
        filename = trainingData.imageFilename(i);
        filename = filename{1};
        filename = strrep(filename,'Training_data_V','labels');
        filename = strrep(filename,'.png','.txt');
        labels_file = fopen( filename, 'wt' );
        if (contains(filename, 'AIRPLANE'))
            data = trainingData.AIRPLANE(i);
            data = data{1};
            if (~isempty(data))
                objs = size(data);
                for j = 1:objs(1)
                    x_center = min(width, max(0, (data(j, 1)+(data(j, 3)/2.0))/width));
                    y_center = min(height, max(0, (data(j, 2)+(data(j, 4)/2.0))/height));
                    w = min(width, max(0, data(j, 3)/width));
                    h = min(height, max(0, data(j, 4)/height));
                    fprintf( labels_file, '1 %f %f %f %f\n', x_center, y_center, w, h);
                end
            end
        elseif (contains(filename, 'BIRD'))
            data = trainingData.BIRD(i);
            data = data{1};
            if (~isempty(data))
                objs = size(data);
                for j = 1:objs(1)
                    x_center = min(width, max(0, (data(j, 1)+(data(j, 3)/2.0))/width));
                    y_center = min(height, max(0, (data(j, 2)+(data(j, 4)/2.0))/height));
                    w = min(width, max(0, data(j, 3)/width));
                    h = min(height, max(0, data(j, 4)/height));
                    fprintf( labels_file, '2 %f %f %f %f\n', x_center, y_center, w, h);
                end
            end
        elseif (contains(filename, 'DRONE'))
            data = trainingData.DRONE(i);
            data = data{1};
            if (~isempty(data))
                objs = size(data);
                for j = 1:objs(1)
                    x_center = min(width, max(0, (data(j, 1)+(data(j, 3)/2.0))/width));
                    y_center = min(height, max(0, (data(j, 2)+(data(j, 4)/2.0))/height));
                    w = min(width, max(0, data(j, 3)/width));
                    h = min(height, max(0, data(j, 4)/height));
                    fprintf( labels_file, '0 %f %f %f %f\n', x_center, y_center, w, h);
                end
            end
        elseif (contains(filename, 'HELICOPTER'))
            data = trainingData.HELICOPTER(i);
            data = data{1};
            if (~isempty(data))
                objs = size(data);
                for j = 1:objs(1)
                    x_center = min(width, max(0, (data(j, 1)+(data(j, 3)/2.0))/width));
                    y_center = min(height, max(0, (data(j, 2)+(data(j, 4)/2.0))/height));
                    w = min(width, max(0, data(j, 3)/width));
                    h = min(height, max(0, data(j, 4)/height));
                    fprintf( labels_file, '3 %f %f %f %f\n', x_center, y_center, w, h);
                end
            end
        end

        fclose(labels_file);
    end
end
