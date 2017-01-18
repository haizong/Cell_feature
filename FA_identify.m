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
size_thresh_FA_low = 30;
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
        bw2 = bwareaopen( bw, 30 );
        figure()
        subplot (3,2,1)
        imshow(bw2)
        title ('bwareopen 10');
        
        % Apply Watershed algorithm to divide grouped FAs to distinct FA.
        D = -bwdist(~bw);
        subplot (3,2,2)
        imshow(D,[],'InitialMagnification','fit');
        title('Distance transform of ~bw');
        
        % Compute the watershed transform and display the resulting label matrix as an RGB image.
        
        Ld = watershed(D);
        rgb = label2rgb(L,'jet',[.5 .5 .5]);
        subplot (3,2,3)
        imshow(rgb,'InitialMagnification','fit')
        title('Watershed transform of D')
        
        % The watershed ridge lines, in white, correspond to Ld == 0. 
        % Let's use these ridge lines to segment the binary image by changing 
        % the corresponding pixels into background.
        bw2(Ld == 0) = 0;
        subplot (3,2,4)
        imshow(bw2)
        title('Watershed transform of D');
        
        mask = imextendedmin(D,50);
        imshowpair(bw,mask,'blend')
        D2 = imimposemin(D,mask);
        Ld2 = watershed(D2);
        bw3 = bw2;
        bw3(Ld2 == 0) = 0;
        figure()
        imshow(bw3)
        
        % Count the number of discovered cells.
        [L_matrix, num] = bwlabel(L);  % this num is off by +1
        
        % Let's overlay the detected cells over the original grayscale image to
        % visually evaluate the performance of the algorithm
        mask = im2bw(L_matrix, 1);
        % Objects on the borders can be caused by noise and other artifacts.
        
        overlay3 = imoverlay(cell_data(i).FA.FA_mask, mask , [1 .3 .3]);
        rps = regionprops( mask, 'Area', 'centroid', 'Eccentricity');
        num = length (rps);
        
        % figure()
        %         subplot(2,2,1);
        %         imshow(img, []);
        %         subplot(2,2,2);
        %         imshow(tophatFiltered, []);
        %         subplot(2,2,3);
        %         imshow(bw1, []);
        %         subplot(2,2,4);
        %         imshow(overlay3, []);
        
    end
end