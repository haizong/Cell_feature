%% This code quantifies FA number and size.
% Parameters were optimized for using 63x oil objective on our new scope.
% Note that many parameters need to be adjusted if the code is used for
% other conditions.
% -------------------------------------------------------------------------
% This code read images in folder and extract morphology properties first on actin.
% Based on the bounding box from actin, it goes to FITC channel to identify
% FA.
% Go to the folder that contains the folder with name of 'dir_name'.
% eg, Directory: /Users/hailingzong/Dropbox/4 Cell_migration/Imaging...
% /2.Focal_adhesion/20170109_paxillin_set1

% HZ    December, 2016  Bloomington   MATLAB 2016a
%% Initiate
clc; clear;
close all;
tic
% dir_name = '20170109_R1. Neg2';
% dir_name = '20170109_R1. MCAK2'; 
% dir_name = '20170109_R2. Neg2';
% dir_name = '20170109_R2. MCAK2';
% dir_name = '20170109_R3. Neg2';
% dir_name = '20170109_R3. MCAK2';
fontsize = 12;
size_scale = 0.5; % Image is too. Convert to 1024 x 768 image to display.
size_thresh_actin_low = 30000;
size_thresh_actin_up = 500000;
int_thresh_actin = 300;
int_thresh_FA = 200;
size_thresh_FA_low = 20;
%% Read images
cell_data = read_folder(dir_name);

%% Segment cells & Extract parameter
cell_data = cellSegment_featureExtraction_FA(cell_data, dir_name, ...
    size_thresh_actin_low,size_thresh_actin_up, int_thresh_actin);

%%
cell_data = focalAdhesionIdentify (cell_data, dir_name, int_thresh_FA, ...
    size_thresh_FA_low, size_scale); 

%% Manually remove joint cells
% '20170109_R1. Neg2' #5, #20 cells too close to be separated. 
%% Remove unwanted fields and Save. Too big to save all info. 
fields = {'ori_img', 'Red_gray', 'labeledImage', 'actin_rps'};
cell_data_rps = rmfield( cell_data, fields);  
save( ['FA_rps_', dir_name([1:11,14:end])],... % rm space in filename
    'cell_data_rps', 'dir_name', 'size_thresh_actin_low', 'size_thresh_actin_up',...
    'size_thresh_FA_low'); 
toc