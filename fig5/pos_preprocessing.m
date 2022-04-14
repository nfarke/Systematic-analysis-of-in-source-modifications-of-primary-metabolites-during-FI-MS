%function pos_preprocessing()
%load fiadata_purmep
load db_ecoli1_v5

files = fia_data(1).files;
for k = 1:length(files)
    posx = strfind(files{k},'_');
    file_abbr{k} = files{k}(1:posx-1);
end
file_abbr = unique(file_abbr,'stable');

%pos mode
mzy_pos   = fia_data(1).ann.mzy;
mz        = fia_data(1).mz;
int       = fia_data(1).int;
mzall_pos = fia_data(1).ann.mzall;
avg_mzall_pos = fia_data(1).ann.annot.ref_mass - fia_data(1).ann.annot.dmz;

%fill mzy
[row,col] = find(isnan(mzall_pos));

for k = 1:length(row)    
    rowx = row(k);
    colx = col(k);
    massx = avg_mzall_pos(rowx);
    [~,posx]  = min(abs(mz - massx));
    mzy_pos(rowx,colx)   = int(colx,posx);
    disp(k/length(row)*100)
end

%zcore averaged data to find outliers
data_avg_zscored = zscore(log(mzy_pos),[],2); %zscore each annotated peak
fia_data(1).file_abbr = file_abbr;
fia_data(1).data_zscore  = data_avg_zscored;


%save('fiadata_hispur','fia_data','-v7.3')
%end