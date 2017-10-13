% montage FITCimages

% dir_name = '20170109_R1. Neg2';
% dir_name = '20170109_R1. MCAK2';
% dir_name = '20170109_R2. Neg2';
% dir_name = '20170109_R2. MCAK2';
% dir_name = '20170109_R3. Neg2';
dir_name = '20170109_R3. MCAK2';

cell_data = read_folder(dir_name);

TIFF_list_all = dir([dir_name, '/*.TIF']);
TIFF_list = {};
for i = 1:length(TIFF_list_all);
    if isempty(strfind(TIFF_list_all(i).name, 'thumb'));
        TIFF_list = [TIFF_list, TIFF_list_all(i).name];
    end;
end;

% fprintf('Load files from directory: %s\n', dir_name);
% if mod(length(TIFF_list), 3);
%     fprintf(2, 'ERROR: TIFF images sets (of 3) incomplete.\n');
%     fprintf(2, '       %d non-thumb TIF files present.\n', length(TIFF_list));
%     return;
% end;
% fprintf('Load %d non-thumb TIF images from directory.\n', length(TIFF_list));
% fprintf('Group into %d spindles {DAPI, FITC, TexRd}.\n\n', length(TIFF_list)/3);

cell_data = [];

for i = 1:3:length(TIFF_list);
    file_id = TIFF_list{i}(1:(length(dir_name) + 5));
    % fprintf('[<strong>%d</strong> of %d] Reading: %s *3.TIF, ...\n', (i-1)/3+1, length(TIFF_list)/3, file_id);
    cell_data((i+2)/3).name = file_id(1:end-1);
    im_input = read_TIFF(file_id);
    cell_data((i+2)/3).ori_img.DAPI = double(im_input(:,:,3));
    cell_data((i+2)/3).ori_img.TexasRed = double(im_input(:,:,2));
    cell_data((i+2)/3).ori_img.FITC = double(im_input(:,:,1));
    
end
%%
figure()
for i = 1:length(cell_data)
    subplot (6, 6, i)   % need to change the layout to (7, 7, i) when plotting R2.
    imshow(imresize(cell_data(i).ori_img.FITC,0.5), [200 1500]);
end;
print_save_figure(gcf, [dir_name, '_Montage']);
close all; 
fprintf('All done.\n');
