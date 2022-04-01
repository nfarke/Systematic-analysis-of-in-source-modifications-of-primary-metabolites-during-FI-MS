load Outlier_data
[out1,out2] = xlsread('Supplements2','Literature_MassShifts_Truncated');
shifts = out1;
group = out2(2:end,2);

[POS_dmz,N_pos,edges_pos,edge_mean_pos,Ncorrected_pos] = get_differences(POS);
[NEG_dmz,N_neg,edges_neg,edge_mean_neg,Ncorrected_neg] = get_differences(NEG);

%positive mode
[pks,locs] = findpeaks(Ncorrected_pos,'MinPeakHeight',50,'MinPeakProminence',50);
peak_mz_pos    = edge_mean_pos(locs);
[pks_sorted_pos,sortid_pos] = sort(pks,'descend');
mz_sorted_pos = peak_mz_pos(sortid_pos);

%negative mode
[pks,locs] = findpeaks(Ncorrected_neg,'MinPeakHeight',5,'MinPeakProminence',5);
peak_mz_neg    = edge_mean_neg(locs);
[pks_sorted_neg,sortid_neg] = sort(pks,'descend');
mz_sorted_neg = peak_mz_neg(sortid_neg);


grp_counts_pos = get_group_counts(shifts,group,mz_sorted_pos,pks_sorted_pos);
grp_counts_neg = get_group_counts(shifts,group,mz_sorted_neg,pks_sorted_neg);
total_group_counts = grp_counts_pos + grp_counts_neg;

%plots
figure(1)
pie(total_group_counts./sum(total_group_counts),{'Reactions','Adducts','Natural Isotope Abundance'})

