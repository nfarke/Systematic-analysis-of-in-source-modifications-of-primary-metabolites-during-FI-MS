function [Is_Annotated_neg,Is_Outlier_neg,AnnotationCount_neg,Peak_picked_neg] = Fig1_MH_neg_processing()

load fia_data_MH
load db_ecoli1_v5
[~,out2] = xlsread('Supplements1.xlsx');

standard_abbr         = out2(2:161,3);
standard_kegg         = out2(2:161,8);

annot_neg = fia_data(2).ann.annot;
mzall_neg = fia_data(2).ann.mzall;
data_avg_zscored = fia_data(2).data_zscore;
file_abbr = fia_data(2).file_abbr;
error_neg = fia_data(2).error;

mzy = fia_data(2).ann.mzy;
%average mzy
cntr = 1;
for k = 1:3:size(mzy,2)
    data_sparse(:,cntr) = mean(mzy(:,k:k+2),2,'omitnan');
    data_nonan(:,cntr)  = mean(mzy(:,k:k+2),2);
    cntr = cntr + 1;   
end

Is_Annotated_neg = zeros(length(standard_abbr),1);
Is_Outlier_neg   = zeros(length(standard_abbr),1);
AnnotationCount_neg = zeros(length(standard_abbr),1);
Peak_picked_neg     = zeros(length(standard_abbr),1);
ERROR = zeros(length(standard_abbr),1);
error_endogenous = nan(160,1);

for k = 1:length(standard_abbr)
    kegg = standard_kegg{k};
    abbr = standard_abbr{k};
    idx = find(strcmp(kegg,annot_neg.kegg_id));
    idx2 = find(strcmp(abbr,file_abbr));
    zscorex = data_avg_zscored(idx,idx2);
    if ~isempty(idx)
        Is_Annotated_neg(k) = single(idx>0);
        AnnotationCount_neg(k) = sum(~isnan(mzall_neg(idx,:)));
        Is_Outlier_neg(k) = zscorex;
        Peak_picked_neg(k) = ~isnan(data_sparse(idx,idx2))*1;
        ERROR(k,1)         = error_neg(idx,idx2);
        val = data_nonan(idx,setdiff(find(~isnan(data_nonan(idx,:))),idx2));
        if length(val) >= 3
           err = std(val)/mean(val);
           error_endogenous(k,1) = err;
        end
    end 
end

end
