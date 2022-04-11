load fia_data_MH
load Outlier_data
[out1,out2] = xlsread('Supplements2','Analytical_Standards');
abbrx = out2(2:161,3);
class = out2(2:161,11);
abbr = fia_data(1).file_abbr;

for k = 1:length(abbr)
    indexes(k) = find(strcmp(abbr{k},abbrx));
end
classx = class(indexes);

unique_classes = unique(classx);

cmz_pos = fia_data(1).CMZ;
cmz_neg = fia_data(2).CMZ;

pos_filled = fia_data(1).FY_filled;
neg_filled = fia_data(2).FY_filled;
all_filled = vertcat(pos_filled,neg_filled);

out = tsne(all_filled','perplexity',20);
colors = {'k','b','r','g','m','c'};

for k = 1:length(unique_classes)
    classxx = unique_classes{k};
    ids = ismember(classx,classxx);
    scatter(out(ids,1),out(ids,2),colors{k},'filled')
    hold on
    text(out(ids,1),out(ids,2),abbr(ids))
    legend(unique_classes)
end