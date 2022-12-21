function fia_import_save_as_mat

[files, path] = uigetfile('*.mzXML','MultiSelect', 'on');

%% make map file
for i = 1:numel(files)
    dumy1 = files{i}; 
    posneg(i,1) =  {dumy1};
    sample(i,1) =  {dumy1([1:end-13])};
end
    
int_out = zeros(length(files),10^6);

for k = 1:size(files,2)
    disp(['file ' num2str(k)])
    [mz_x, int,rt]     = extract_mzint_chrom([path files{k}]);
    
    save(files{k}(1:end-6),'mz_x','int','rt','-v7.3')
end