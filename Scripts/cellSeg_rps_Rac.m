%% For RPE1 cells taken images under 40x oil objective on Walczak new scope.
% -------------------------------------------------------------------------
% Description
% The 1st code to run for cell morphology analysis. Segment cells on FITC.
% This code read images in folder and extract morphology properties.
% Note that parameters need to be readjusted if the code is used for
% other imaging conditions/differnt analysis purposes.

% Go to the folder that contains the folder name of 'dir_name' - folder contains images of one exp condition.
% eg, Directory: /Users/hailingzong/Dropbox/7 Thesis/4_Chapter_4/Fig4.4_Rac1_OX

% Note that the sequence of 3 channels need to be 'w1DAPI.TIF', 'w2FITC.TIF', 'w3Texas Red.TIF',  

% HZ    Oct, 2017  Mountain View   MATLAB 2016a

%% Initiate
tic;
clc; clear;
close all;

fontsize = 12;
size_scale = 0.5; % Image is too big. Convert to 1024 x 768 image to display.
size_threshold = 5000;
int_threshold = 225;  % Segment cells based on FITC signal > 225 gray level. 


% dir_name = '20170918_Set1_Neg2_GFP';
% dir_name = '20170918_Set1_Neg2_GFP-Rac1';
% dir_name = '20170918_Set1_M2_GFP';
% dir_name = '20170918_Set1_M2_GFP-Rac1';

% dir_name = '20170918_Set2_Neg2_GFP';
% dir_name = '20170918_Set2_Neg2_Rac1-GFP';
% dir_name = '20170918_Set2_MCAK2_GFP';
% dir_name = '20170918_Set2_MCAK2_Rac1-GFP';

% dir_name = '20170919_Set3_Neg2_GFP';
% dir_name = '20170919_Set3_Neg2_Rac1-GFP';
% dir_name = '20170919_Set3_MCAK2_GFP';
% dir_name = '20170919_Set3_MCAK2_Rac1-GFP';

% dir_name = '20170919_Set4_Neg2_GFP';
% dir_name = '20170919_Set4_Neg2_Rac1-GFP';
% dir_name = '20170919_Set4_MCAK2_GFP';
% dir_name = '20170919_Set4_MCAK2_Rac1-GFP';

% dir_name = '20170919_Set5_Neg2_GFP';
% dir_name = '20170919_Set5_Neg2_Rac1-GFP';
% dir_name = '20170919_Set5_MCAK2_GFP';
dir_name = '20170919_Set5_MCAK2_Rac1-GFP';
%% Read images
cell_data = read_folder(dir_name); 

%% Segment cells & Extract parameter
cell_data = cellSegment_featureExtraction_Rac (cell_data, dir_name, ...
    size_threshold, int_threshold); 

%% Remove unwanted fields and Save. Too big to save all info. 
fields = {'ori_img', 'Green_gray', 'labeledImage'}; 
cell_data_rps = rmfield( cell_data, fields);  
save( ['cell_data_rps_', dir_name], 'cell_data_rps', 'dir_name', 'size_threshold', 'int_threshold');  
fprintf( 'Cell_data.mat saved \n' ); 
toc; 