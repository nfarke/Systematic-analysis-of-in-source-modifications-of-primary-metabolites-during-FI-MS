load('fiadata_purmep_900_500');
load('iJO1366.mat')
load db_ecoli1_v5
[~,out2] = xlsread('gene_bnum');
load iJOCNUM

mz = fia_data(1).mz;
mzy_pos = fia_data(1).ann.mzy;
mzy_neg = fia_data(2).ann.mzy;
mzall_pos = fia_data(1).ann.mzall;
mzall_neg = fia_data(2).ann.mzall;
int_pos = fia_data(1).int;
int_neg = fia_data(2).int;

files = fia_data(1).files;
for k = 1:length(files)
     posx = strfind(files{k},'_');
     file_abbr{k} = files{k}(1:posx-1);
end
abbr = unique(file_abbr,'stable');
abbr = abbr(10:end);
cmz = fia_data(1).CMZ;

mzy_pos_filled = mzy_pos;
for k = 1:length(mzy_pos)
    mzavg     = mean(mzall_pos(k,:),'omitnan');
    [~,posx] = min(abs(mzavg - mz));
    int_val   = int_pos(:,posx);
    mzy_pos_filled(k,:) = int_val; 
end
mzy_neg_filled = mzy_neg;
for k = 1:length(mzy_neg)
    mzavg     = mean(mzall_neg(k,:),'omitnan');
    [~,posx] = min(abs(mzavg - mz));
    int_val   = int_neg(:,posx);
    mzy_neg_filled(k,:) = int_val; 
end

%get data from fia_data
kegg_pos  = fia_data(1).ann.annot.kegg_id;
metname_pos = fia_data(1).ann.annot.abbr;
%mzy_pos_filled    = fia_data(1).mzy_filled;

kegg_neg  = fia_data(2).ann.annot.kegg_id;
%mzy_neg_filled    = fia_data(2).mzy_filled;
metname_neg = fia_data(2).ann.annot.abbr;

%merge
kegglist = vertcat(kegg_pos,kegg_neg);
datax  = vertcat(mzy_pos_filled,mzy_neg_filled);
metname = vertcat(metname_pos,metname_neg);

%set gene order and sort according to file names
new_order = {'C1','C2','C3','C4','C5','C6','C7','C8','C9','purF','purD','purN','purT',...
             'purL','purM','purK','purE','purC','purB','purH','purA','ispD','ispE','ispF','ispG','ispH'};       

for k = 1:length(new_order)
    posx(k) = find(strcmp(new_order{k},file_abbr));
end
filex = file_abbr(posx);
datax = datax(:,posx);
datax = zscore(log(datax),[],2);

[out1,out3] = xlsread('Supplements4');
target_genes = out3(2:end,2);
target_keggs = out3(2:end,6);
target_metnames = out3(2:end,4);
target_mass     = out1;
target_mass_pos = target_mass + 1.0073;
target_mass_neg = target_mass - 1.0073;



INT = [];
METs = {};
for k = 1:length(filex)
    genex = filex{k};
    idx = find(strcmp(genex,target_genes));
    for kk = 1:length(idx)
        keggx = target_keggs(idx(kk));
        metss = target_metnames(idx(kk));
        massesx = target_mass(idx(kk));
        [row,~] = find(ismember(kegglist,keggx));
    
        %choose between pos and neg mode based on peak z score
        [~,ix] = max(max((datax(row,:)')));
        row = row(ix);
    
        INT = vertcat(INT,datax(row,:));
        METs = vertcat(METs,metname(row,1));
     end
end

INTx = INT';
INTx(1:9,:) = [];
INTx = INTx';
INTx(INTx<0)= 0;
%INTx = INTx > 3;
%INTx = double(INTx);
    
[METsU,ia] = unique(METs,'stable');
INTx = INTx(ia,:);

%Plot heatmap
r = [240 135 5]/255;        %# start
w = [246 225 181]/255;      %# middle
b = [0 158 227]/255;       %# end
%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(r(i), w(i), 32);
    c2(:,i) = linspace(w(i), b(i), 32);
end
C2 = [c1(1:end-1,:);c2];
filex = filex(10:end);

INT_his = INTx(1:8,1:8);
row_his = METsU(1:8);
col_his  = filex(1:8);

%all
aaa = HeatMap(INTx,'RowLabels',METsU,'ColumnLabels',filex,'ColorMap',C2,'DisplayRange',3);