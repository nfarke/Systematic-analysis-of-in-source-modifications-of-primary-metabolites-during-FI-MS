function [] = figure1f()
load fia_data_MH
load db_ecoli1_v5
[out1_num,out1] = xlsread('Supplements1.xlsx');
[~,out2] = xlsread('Supplements1.xlsx','Analytical_Standards');
preferred_adducts = out2(2:161,33);
preferred_val = sum(out1_num(1:160,30:31) > 3,2);

file_abbr = fia_data.file_abbr;
standard_abbr         = out1(2:161,3);

data_zscore_pos     = fia_data(1).data_zscore;
data_abbr_pos       = fia_data(1).ann.annot.abbr;
data_zscore_neg     = fia_data(2).data_zscore;
data_abbr_neg       = fia_data(2).ann.annot.abbr;

data_zscore = vertcat(data_zscore_pos,data_zscore_neg);
data_abbr   = vertcat(data_abbr_pos,data_abbr_neg);
new_data = [];

for k = 1:length(preferred_adducts)
    if isempty(preferred_adducts{k})
       idxx(k) = 1;
    else
       idxx(k) = 0;
    end
end
preferred_val(find(idxx)) = [];

preferred_adducts(find(idxx)) = [];
standard_abbr(find(idxx)) = [];

for k = 1:length(preferred_adducts)
    adduct  = preferred_adducts{k};
    posx = strfind(adduct,'[');
    adductsX{k,1} = adduct(posx:end);
    abbr  = standard_abbr{k};
    idx2(k) = find(strcmp(abbr,file_abbr));
    id = find(strcmp(adduct,data_abbr));
    dat = data_zscore(id,:);
    new_data = vertcat(new_data,dat);
end

new_data1     = new_data(:,idx2);
new_data2 = single(new_data1 > 3);

%sort for adducts
id1 = strcmp('[M+H]+',adductsX);
id2 = strcmp('[M-H]-',adductsX);
idx = [find(id1);find(id2);];

new_data2 = new_data2.*id1*1 + new_data2.*id2*-1;
new_data2 = new_data2(idx,idx);

column_labels   = standard_abbr(idx);
row_labels =  preferred_adducts(idx);
preferred_val = preferred_val(idx);



%plot heatmap
r = [26 181 177]/255;        %# start
w = [230 230 230]/255;      %# middle
b = [166 26 181]/255;       %# end
%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(r(i), w(i), 32);
    c2(:,i) = linspace(w(i), b(i), 32);
end
C2 = [c1(1:end-1,:);c2];
aaa = HeatMap(new_data2,'RowLabels',row_labels,'ColumnLabels',column_labels,'ColorMap',C2);%,'DisplayRange',13);


%%
num_unspec_targets = sum(sum(abs(new_data2))) - sum(diag(abs(new_data2)));
only_offdiag = abs(new_data2) - diag(diag(abs(new_data2)));
num_standards_w_offtargets = sum(only_offdiag,1);
[numoff, sortid] = sort(num_standards_w_offtargets,'descend');

aaa1 = HeatMap(new_data2(sortid,sortid),'RowLabels',row_labels(sortid),'ColumnLabels',column_labels(sortid),'ColorMap',C2);%,'DisplayRange',13);
bar(numoff)

%%%
preferred_val = preferred_val(sortid);

new_datax = new_data2';
new_datax(boolean(eye(length(new_datax))))= zeros;

%get unspecific outliers
[row,col] = find(new_datax);
standardx = column_labels(row);
adductx   = row_labels(col);
Result    = horzcat(adductx,standardx);

end
