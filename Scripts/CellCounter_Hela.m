%% For HeLa cells
% -------------------------------------------------------------------------
% Description
% This code counts cells in transwell migration assay (Christina Moe).
% Note that many parameters need to be adjust if the code is used for
% another kind of image analysis.

% HZ    April, 2016  Bloomington

%% Initiate
tic;
clc; clear;
close all;
fontsize = 12;
bg_cutoff = 110;  
size_threshold = 700; % min_size = 1200 for MDAs; 700 for HeLas
size_scale = 0.5; % Image is too big. Convert to 1024 x 768 image to display.

%%% Go to the upper level where images are stored.
%  Directory: /Users/hailingzong/Documents/MATLAB/3-7-16 Transwell Assay

% dir list all images
folder_info = dir('*.tif');
% Remove . files
folder_info = folder_info(arrayfun(@(x) x.name(1), folder_info) ~= '.');

%% Read the image. rgb -> grayscale & enhance contrast
image_info = [];
image_info_short = []; 
% for i = 1:5
for i = 1:length(folder_info)
    image_info(i).name = folder_info(i).name;
    image_info_short (i).name = image_info(i).name;
    fprintf( ['Currently @ #', num2str(i),' ', image_info(i).name, '\n'] );
    image_info(i).ori_img = imread(folder_info(i).name);
    
    % Convert image to 8 bit, grayscale image.
    image_info(i).img_gray = rgb2gray( image_info(i).ori_img );
    
    % Switch image color to darkbackground,bright cells. 
    img_cmp = imcomplement( image_info(i).img_gray );

    figure(1)
    hold on;
    subplot(2,2,1)
    imshow( imresize( image_info(i).ori_img, size_scale ),[] );
    title( '[0] Original image', 'fontsize', fontsize );
    subplot(2,2,2)
    imshow( imresize( image_info(i).img_gray, size_scale ),[] );
    title( '[1] Grayscale image', 'fontsize', fontsize );
    subplot(2,2,3)
    imhist( image_info(i).img_gray );  % Display histogram of image data.
    title( 'Histogram of intensity', 'fontsize', fontsize );
    subplot(2,2,4)
    imshow ( imresize( img_cmp-150, size_scale ), [] );
    title( '[2] Subtract background', 'fontsize', fontsize );
    print_save_figure( gcf, [image_info(i).name, '_Fig1' ], 'Processed' );
    close;
    
    %% Segmentation
    
    % Remove noise by adaptive filtering, using a small window (5x5 pixels).
    % The changes are barely noticeable to the human eye,
    % but they greatly reduce the number of incorrect cells found.
    I = wiener2( img_cmp, [5 5] );
    
    % Graythresh finds a global threshold using Otsu's method.
    % Then convert the greyscale image to binary:
    % bw = im2bw( I, graythresh(I));
    bw = I > bg_cutoff;
    % Fill image regions and holes. Only necessary when the cell have varying
    % contrast within themselves.
    bw2 = imfill( bw,'holes' );
    
    % Morphological opening using a disc kernel
    bw3 = imopen( bw2, strel('disk', 10) );
    
    % Remove objects that are too small to be cells. Set size_threshold @ step1.
    bw4 = bwareaopen( bw3, size_threshold );
    
    figure(2)
    subplot(2,2,1)
    imshow ( imresize( I, size_scale ), [] );
    title( '[3] Adaptive filtering', 'fontsize', fontsize );
    subplot(2,2,2)
    imshow ( imresize( bw, size_scale ), [] );
    title( '[4] Binary image', 'fontsize', fontsize );
    subplot(2,2,3)
    imshow ( imresize( bw3, size_scale ), [] );
    title( {'[5] clear border'; '[6] Fill holes'; '[7] Image opening'}, 'fontsize', fontsize );
    subplot(2,2,4)
    imshow ( imresize( bw4, size_scale ), [] );
    title( '[8] Size threshold', 'fontsize', fontsize );
    print_save_figure( gcf, [image_info(i).name, '_Fig2' ], 'Processed' );
    close; 
    %% Apply Watershed algorithm to divide grouped cells to distinct cells.
    % The watershed algorithm interprets the gray level of pixels as the altitude of a relief.
    % For this reason we need to modify our image so that the cell borders have
    % the highest intensity and the background is clearly marked (we mark is as
    % negative infinity). We achieve this by first finding the maxima which
    % should approximately correspond to the cell nuclei and then we transform
    % the image such that the background pixels and these maxima are the only
    % local minima in the image.
    
    % Overlay perimeter of identified cells and the grayscale image.
    % We use the imoverlay function written by Steven L. Eddins.
    bw4_perim = bwperim(bw4);
    overlay1 = imoverlay(I, bw4_perim, [1 .3 .3]);
    
    % Discover putative cell centroids
    maxs = imextendedmax(I,  5);
    maxs = imclose(maxs, strel('disk',3));
    maxs = imfill(maxs, 'holes');
    maxs = bwareaopen(maxs, 50);  % original 70
    overlay2 = imoverlay(I, bw4_perim | maxs, [1 .3 .3]);
    
    % Modify the image so that the background pixels and the extended maxima
    % pixels are forced to be the only local minima in the image.
    Jc = imcomplement(I);
    I_mod = imimposemin(Jc, ~bw4 | maxs);
    
    I_watershed = watershed(I_mod);  %
    % Eliminate cells on the boundary.
    clearborder = imclearborder(I_watershed); 
    % Label objects
    image_info(i).labeledImage = label2rgb(clearborder);
    % Count the number of discovered cells.
    [L_matrix, num] = bwlabel(clearborder);  % this num is off by +1
    
    % Let's overlay the detected cells over the original grayscale image to
    % visually evaluate the performance of the algorithm
    mask = im2bw(L_matrix, 1);
    % Objects on the borders can be caused by noise and other artifacts.
    
    overlay3 = imoverlay(image_info(i).ori_img, mask , [1 .3 .3]);
    
    % Get cell number, nuclear area, centroid position, and eccentricity
    image_info(i).rps_cell = regionprops( mask, 'Area', 'centroid', 'Eccentricity');
    num = length (image_info(i).rps_cell);
    
    %% Plot data
    Nucleus_size = [image_info(i).rps_cell.Area];
    % hist(Nucleus_size, 15);
    % Watershed tend to break a weird-shaped object into two.
    % We further remove those cells by eliminating 5% of cells whose nuclus
    % size is on the lower end. By this means, we count 95% cells.
    image_info(i).ds_area = ...
        getDescriptiveStatistics(Nucleus_size, {'percent', [5 50 95]});
    image_info(i).rps_cell_new = []; 
    true_cell_num = 0; 
    for n = 1:length(image_info(i).rps_cell)
        if image_info(i).rps_cell(n).Area > size_threshold 
            image_info(i).rps_cell(n).trueCell = 1;
            true_cell_num = true_cell_num + 1; 
            image_info(i).rps_cell_new = ...
                [image_info(i).rps_cell_new; image_info(i).rps_cell(n)];  
        else image_info(i).rps_cell(n).trueCell = 0;
        end
    end
    
    image_info(i).cell_num = sum([image_info(i).rps_cell.trueCell]);
    image_info_short (i).cell_num = image_info(i).cell_num ;
    %%
    figure(3)
    subplot (2,2,1)
    imshow ( imresize( overlay2, size_scale ), [] );
    title( '[9] Show putative cell centroids', 'fontsize', fontsize );
    subplot (2,2,2)
    imshow ( imresize( I_mod, size_scale ), [] );
    title( '[10] Display local minima', 'fontsize', fontsize );
    subplot (2,2,3)
    imshow ( imresize( image_info(i).labeledImage, size_scale ), [] );
    title( '[11] Watershed: separate overlapping cells', 'fontsize', fontsize );
    subplot (2,2,4)
    imshow ( imresize( overlay3, size_scale ), [] );
    title( {'[12] Detected cells over grayscale image'; ...
        ['Number of cells detected:', num2str(image_info(i).cell_num)]},...
        'fontsize', fontsize );
    print_save_figure( gcf, [image_info(i).name, '_Fig3' ], 'Processed' );
close; 

%%  Plot summary
figure(4)
    imshow ( imresize(image_info(i).ori_img, size_scale), []);
    hold on
    xy = [image_info(i).rps_cell_new.Centroid];
    x = xy(1:2:end);
    y = xy(2:2:end);
    color = 'y';
    plot (x/2, y/2, 'o', 'LineWidth',2, 'MarkerSize',2,...
         'MarkerEdgeColor', color, 'MarkerFaceColor', color);
    title( [image_info(i).name(1:end-4), '      Number of cells detected: ',...
        num2str(image_info(i).cell_num)], 'interpreter', 'none',...  
        'fontsize', fontsize );
    print_save_figure( gcf, image_info(i).name(1:end-4), 'Summary' );
end
toc;

fprintf( 'Saving image_info.mat ...\n' ); tic
save('image_info', 'image_info');  % This takes a while
toc

fprintf( 'Saving image_info_short.mat ...\n' ); tic
save('image_info_short', 'image_info_short');
toc
