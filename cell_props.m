%% For RPE1 cells taken images under 40x oil objective
% -------------------------------------------------------------------------
% Description
% This code extract morphology properties.
% Note that many parameters need to be adjusted if the code is used for
% another kind of image analysis.

% Go to the folder that contains the folder with name of 'dir_name'.
% eg, Directory: /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/20161219_set1

% HZ    December, 2016  Bloomington

%% Initiate
clc; clear;
close all;
dir_name = '20161222_R3. MCAK2';
fontsize = 12;
size_scale = 0.5; % Image is too. Convert to 1024 x 768 image to display.
size_threshold = 5000;
int_threshold = 220; 

%% Read images
cell_data = read_folder(dir_name); 

%% Segment cells & Extract parameter
cell_data = cellSegment_featureExtraction(cell_data, dir_name, ...
    size_threshold, int_threshold); 

%% Remove unwanted fields and Save. Too big to save all info. 
fields = {'ori_img', 'Red_gray', 'labeledImage'};
cell_data_rps = rmfield( cell_data, fields);  
save( ['cell_data_rps_', dir_name([1:11,'_', 14:end])],... % rm space in filename
    'cell_data_rps', 'dir_name', 'size_threshold', 'int_threshold');  
fprintf( 'Cell_data.mat saved \n' ); 
