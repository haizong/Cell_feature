function cell_data = cellSegment_featureExtraction_FA(cell_data, dir_name, ...
   size_thresh_actin_low, size_thresh_actin_up, int_thresh_actin, size_scale, fontsize)

% This function segment cells based on actin fluorescence and extract
% features including 'Area', 'Centroid','BoundingBox', 'ConvexArea',
% 'Eccentricity', 'MajorAxisLength', 'MinorAxisLength','Perimeter',
% 'Solidity', intergrate and average intensity of the red channel (actin).
% HZ    Jan, 2017, Bloomington   MATLAB 2016a
if ~exist('size_scale','var') || isempty(size_scale);
    size_scale = 0.5;
end;
if ~exist('fontsize','var') || isempty(fontsize);
    fontsize = 12;
end;

for i = 1:length(cell_data)
    %% Segmentation
    cell_data(i).Red_gray = mat2gray( cell_data(i).ori_img.TexasRed, [int_thresh_actin 4095] ); % Range[0, i]
    
    % Remove noise by adaptive filtering, using a small window (5x5 pixels).
    I = wiener2( cell_data(i).Red_gray, [5 5] );
    
    % Graythresh finds a global threshold using Otsu's method.
    bw = im2bw( I, int_thresh_actin/(2^16));
    
    % Fill holes. Necessary when the cell have varying contrast within themselves.
    bw2 = imfill( bw,'holes' );
    
    se = strel('line',11,90);
    bw3 = imerode(bw2, se);
    
    % Morphological opening using a disc kernel
    bw33 = imopen( bw3, strel('disk', 2) );
    
    
    % Remove objects that are too small to be cells. Set size_threshold @ step1.
    bw4 = bwareaopen( bw33, size_thresh_actin_low );
    
    % Clear border
    bw5 = imclearborder( bw4 );
    
%     figure ()
%     subplot(2,2,1)
%     imshow ( imresize( I, size_scale ), [] );
%     title( '[1] Adaptive filtering', 'fontsize', fontsize );
%     subplot(2,2,2)
%     imshow ( imresize( bw, size_scale ), [] );
%     title( '[2] Binary image', 'fontsize', fontsize );
%     subplot(2,2,3)
%     imshow ( imresize( bw4, size_scale ), [] );
%     title( {'[3] Fill holes'; '[4] Image opening'}, 'fontsize', fontsize );
%     subplot(2,2,4)
%     imshow ( imresize( bw5, size_scale ), [] );
%     title( '[5] Clear border', 'fontsize', fontsize );
%     
%     print_save_figure( gcf, [cell_data(i).name, '_Fig1_Segment' ],...
%         [dir_name, '/Processed'] );
%     
    % Label objects
    cell_data(i).labeledImage = label2rgb (bw5);
    
    % Count the number of discovered cells
    [L_matrix, raw_num] = bwlabel (bw5);  % this num is off by +1
    
    % Overlay the detected cells over the original grayscale image to
    % visually evaluate the performance of the algorithm
    mask = im2bw (L_matrix, 0);
    
    %% Feature extraction
    % Get cell number, nuclear area, centroid position, and eccentricity
    cell_data(i).actin_rps = regionprops( mask, 'Area', 'Centroid','BoundingBox', ...
        'ConvexArea', 'Eccentricity', 'MajorAxisLength', 'MinorAxisLength',...
        'Perimeter', 'Solidity');
    
    for k = 1:raw_num
        % Calculate intergrate and average intensity of actin area.
        IntDen = zeros (size (cell_data(i).ori_img.TexasRed) );
        IntDen(mask) = cell_data(i).ori_img.TexasRed(mask);
        cell_data(i).actin_rps(k).IntDen_Red = sum( IntDen(L_matrix == k) );
        cell_data(i).actin_rps(k).AveDen_Red = ...
            cell_data(i).actin_rps(k).IntDen_Red/cell_data(i).actin_rps(k).Area;
        
        % Save the image under the BoundingBox under actin_rps.
        x(k) = round(cell_data(i).actin_rps(k).BoundingBox(1));
        y(k) = round(cell_data(i).actin_rps(k).BoundingBox(2));
        x_width(k) = cell_data(i).actin_rps(k).BoundingBox(3);
        y_width(k) = cell_data(i).actin_rps(k).BoundingBox(4);
        
        cell_data(i).actin_rps(k).crop_DAPI = ...
            cell_data(i).ori_img.DAPI( y:(y+y_width), x:(x+x_width) );
        cell_data(i).actin_rps(k).crop_TexasRed = ...
            cell_data(i).ori_img.TexasRed( y:(y+y_width), x:(x+x_width) );
        cell_data(i).actin_rps(k).crop_FITC = ...
            cell_data(i).ori_img.FITC( y:(y+y_width), x:(x+x_width) );
        
        % FA in FITC channel
        if cell_data(i).actin_rps(k).Area < size_thresh_actin_up
        cell_data(i).FA(k).FA_mask = zeros(size(cell_data(i).ori_img.FITC));
        cell_data(i).FA(k).FA_mask (mask) = cell_data(i).ori_img.FITC(mask);
        else cell_data(i).FA(k).FA_mask (mask) = NaN;
        end
    end
end

close all;