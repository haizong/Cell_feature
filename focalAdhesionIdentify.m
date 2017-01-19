function cell_data = focalAdhesionIdentify (cell_data, dir_name, int_thresh_FA, ...
    size_thresh_FA_low, size_scale)

if ~exist('size_scale','var') || isempty(size_scale);
    size_scale = 0.5;
end;
if ~exist('fontsize','var') || isempty(fontsize);
    fontsize = 12;
end;

for i =1:length(cell_data)
    if ~isempty(cell_data(i).FA)
        for k = 1:length(cell_data(i).actin_rps)
            img = imgaussfilt(cell_data(i).FA(k).FA_mask); %Gaussian filter
            I = wiener2( img, [5 5] );  % adaptive filter
   
            % Perform the top-hat filtering and display the image.
            se = strel('disk',12);
            tophatFiltered = imtophat(I,se);   % flattern blackground
            bw =  tophatFiltered >int_thresh_FA;  % intensity filter
            bw2 = bwareaopen( bw, size_thresh_FA_low ); % size filter
            
            % Count number
            [L_matrix, raw_num] = bwlabel(bw2);  % this num is off by +1
            
            % Let's overlay the detected cells over the original grayscale image to
            % visually evaluate the performance of the algorithm
            mask = im2bw(L_matrix, 1);
            
            % overlay3 = imoverlay(cell_data(i).FA.FA_mask, mask , [1 .3 .3]);
            cell_data(i).FA(k).rps = regionprops( mask, 'Area', 'centroid', 'Eccentricity');
            cell_data(i).FA(k).num = length (cell_data(i).FA(k).rps );
            
%             for j = 1:raw_num
%                 % Calculate intergrate and average intensity of actin area.
%                 IntDen = zeros (size (cell_data(i).FA(k).FA_mask) );
%                 IntDen(mask) = cell_data(i).FA(k).FA_mask(mask);
%                 cell_data(i).FA(k).IntDen_Red = sum( IntDen(L_matrix == j) );
%                 cell_data(i).FA(k).AveDen_Red = ...
%                     cell_data(i).FA(k).IntDen_Red/cell_data(i).FA(k).rps(j).Area;
%             end 
%             
            figure()
            subplot (3, 2, 1)
            imshow(imresize(cell_data(i).FA(k).FA_mask, size_scale), []); 
            title('original image');
            subplot (3, 2, 2)
            imshow(imresize(img, size_scale), []); 
            title('Gaussian filter');
            subplot (3, 2, 3)
            imshow(imresize(I, size_scale), []); 
            title('Adaptive filter');
            subplot (3, 2, 4)
            imshow(imresize(bw, size_scale)); 
            title('Intensity filter');
            subplot (3, 2, 5)
            imshow(imresize(bw2, size_scale)); 
            title('Size filter');
            
            print_save_figure( gcf, [cell_data(i).name, '_Fig2_FA_Segment' ],...
                [dir_name, '/Processed'] );
        end
    else 
    end
    close all; 
end