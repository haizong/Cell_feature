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
dir_name = '20170109_R1. Neg2';
fontsize = 12;
size_scale = 0.5; % Image is too. Convert to 1024 x 768 image to display.
size_thresh_actin_low = 40000;
size_thresh_actin_up = 350000;
int_thresh_actin = 300; 
int_thresh_FA = 300; 
size_thresh_FA_low = 20; 
%% Read images
cell_data = read_folder(dir_name); 

%% Segment cells & Extract parameter
cell_data = cellSegment_featureExtraction_FA(cell_data, dir_name, ...
    size_thresh_actin_low,size_thresh_actin_up, int_thresh_actin); 
%% Manually delete the cells that cannot be segmented (neighboring cells)
for i =1
    for k = 1
        img = imgaussfilt(cell_data(i).FA(k).FA_mask);
        % Perform the top-hat filtering and display the image.
        se = strel('disk',12);
        tophatFiltered = imtophat(img,se);
        bw =  tophatFiltered >int_thresh_FA;
        bw1 = bwareaopen( bw, size_thresh_FA_low );
        
        % watershed
        a = regionprops(bw1);
        
        subplot(2,2,1);
        imshow(img, []);
        subplot(2,2,3);
        imshow(tophatFiltered, []);
        subplot(2,2,4);
        imshow(bw1, []);
    end
end