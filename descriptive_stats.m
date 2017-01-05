% Calculate descriptive statistics

% function output = descriptive_stat (data)

data = Area; 

for i = 1:length(data)
    data{2,i} = mean(data{1,i});
    data{3,i} = median(data{1,i});
    data{4,i} = min (data{1,i});
    data{5,i} = max (data{1,i});
    data{6,i} = range(data{1,i});
    data{7,i} = std (data{1,i});
    data{8,i} = var (data{1,i});
end 

% Add label to the left column 
newCellCol = { 'raw_number'; 'mean'; 'median'; 'min'; 'max'; 'range'; 'std'; 'var'; }; 

data = [newCellCol, data]; 
