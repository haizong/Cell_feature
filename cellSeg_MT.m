%% For RPE1 cells taken images under 40x oil objective
% -------------------------------------------------------------------------
% Description
% For quantification of MT intensity based on FITC channel. 
% This code read images in folder and extract morphology properties.
% Note that many parameters need to be adjusted if the code is used in
% other imaging conditions.

% Go to the folder that contains the folder with name of 'dir_name'.
% eg, Directory: /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/20161219_set1

% Note the sequence of 3 channels 'w1DAPI.TIF', 'w2FITC.TIF', 'w3Texas Red.TIF', 
% need to be changed in script 'read_TIFF' if not in this exact order. 

% HZ    March, 2017  Bloomington   MATLAB 2016a

%% Initiate
clc; clear;
close all;
dir_name = '20170225_R4. Neg2';
fontsize = 12;
size_scale = 0.5; % Image is too. Convert to 1024 x 768 image to display.
size_threshold = 5000;
int_threshold = 220; 

%% Read images
cell_data = read_folder(dir_name); 

%% Segment cells & Extract parameter
cell_data = cellSegment_featureExtraction_MT(cell_data, dir_name, ...
    size_threshold, int_threshold); 

%% Remove unwanted fields and Save. Too big to save all info. 
fields = {'ori_img', 'FITC_gray', 'labeledImage', 'FA'}; % Rm 'FA' if it's focal adhesion analysis
cell_data_rps = rmfield( cell_data, fields);  
save( ['MT_rps_', dir_name([1:11]), '_', dir_name([14:end])],... % rm space in filename
    'cell_data_rps', 'dir_name', 'size_threshold', 'int_threshold');  
fprintf( 'Cell_data.mat saved \n' ); 

