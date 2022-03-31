%function fia_import_main(mapfile)
global fia_data


% Get file directorty
[fileMap,pathMap,~]=uigetfile('*.xlsx','Select Map File');
% Open xls data
[~,mapfile,~] = xlsread([pathMap fileMap],'Sheet1');

[files, path] = uigetfile('*.mzXML','MultiSelect', 'on');

int_out = zeros(length(files),10^6);

for k = 1:size(files,2)
    disp(['file ' num2str(k)])
    [mz_x, int] = extract_mzint([path files{k}]);
    mz_out(k,:) = mz_x;
    int_out(k,:)    = int;
end

mz_out = mz_out(1,:);

i1 = find(strcmp(mapfile,'pos'));
i2 = find(strcmp(mapfile,'neg'));

fia_data(1).mz = mz_out;
fia_data(1).int = int_out(i1,:);
fia_data(1).files = files(i1);

fia_data(2).mz = mz_out;
fia_data(2).int = int_out(i2,:);
fia_data(2).files = files(i2);

save('fiadata_his_new','fia_data','-v7.3')
%end
