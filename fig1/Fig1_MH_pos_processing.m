function [Is_Annotated_pos,Is_Outlier_pos,AnnotationCount_pos,Peak_picked_pos] = Fig1_MH_pos_processing()

load fia_data_MH
load db_ecoli1_v5
[~,out2] = xlsread('Supplements1.xlsx');

standard_abbr         = out2(2:161,3);
standard_kegg         = out2(2:161,8);

annot_pos = fia_data(1).ann.annot;
mzall_pos = fia_data(1).ann.mzall;
data_avg_zscored = fia_data(1).data_zscore;
file_abbr = fia_data(1).file_abbr;
error_pos = fia_data(1).error;

mzy = fia_data(1).ann.mzy;
%average mzy
cntr = 1;
for k = 1:3:size(mzy,2)
    data_sparse(:,cntr) = mean(mzy(:,k:k+2),2,'omitnan');
    data_nonan(:,cntr)  = mean(mzy(:,k:k+2),2)
    cntr = cntr + 1;   
end

Is_Annotated_pos = zeros(length(standard_abbr),1);
Is_Outlier_pos   = zeros(length(standard_abbr),1);
AnnotationCount_pos = zeros(length(standard_abbr),1);
Peak_picked_pos     = zeros(length(standard_abbr),1);
ERROR = zeros(length(standard_abbr),1);
error_endogenous = nan(160,1);

for k = 1:length(standard_abbr)
    kegg = standard_kegg{k};
    abbr = standard_abbr{k};
    
    idx = find(strcmp(kegg,annot_pos.kegg_id));
    idx2 = find(strcmp(abbr,file_abbr));
    zscorex = data_avg_zscored(idx,idx2);
    if ~isempty(idx)
        Is_Annotated_pos(k) = single(idx > 0);
        AnnotationCount_pos(k) = sum(~isnan(mzall_pos(idx,:)));
        ERROR(k,1)         = error_pos(idx,idx2);
        val = data_nonan(idx,setdiff(find(~isnan(data_nonan(idx,:))),idx2));
        if length(val) >= 3
           err = std(val)/mean(val);
           error_endogenous(k,1) = err;
        end
        
        Is_Outlier_pos(k) = zscorex; 
        Peak_picked_pos(k) = ~isnan(data_sparse(idx,idx2))*1;
    end 
end

end
