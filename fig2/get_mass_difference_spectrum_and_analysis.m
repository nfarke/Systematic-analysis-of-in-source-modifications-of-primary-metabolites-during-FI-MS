load Outlier_data
[out1,out2] = xlsread('Supplements2','Literature_MassShifts');
shifts = out1;
group = out2(2:end,1);

[POS_dmz,N_pos,edges_pos,edge_mean_pos,Ncorrected_pos] = get_differences(POS);
[NEG_dmz,N_neg,edges_neg,edge_mean_neg,Ncorrected_neg] = get_differences(NEG);

%positive mode
[pks,locs] = findpeaks(Ncorrected_pos,'MinPeakHeight',50,'MinPeakProminence',50);
peak_mz_pos    = edge_mean_pos(locs);
[pks_sorted_pos,sortid_pos] = sort(pks,'descend');
mz_sorted_pos = peak_mz_pos(sortid_pos);

for k = 1:length(shifts)
    shiftx = shifts(k);    
    delta = min(abs(peak_mz_pos - shiftx));  
    if delta < 0.003
       Adduct_Selection(k,1) = 1;
    else
       Adduct_Selection(k,1) = 0;       
    end
end

%negative mode
[pks,locs] = findpeaks(Ncorrected_neg,'MinPeakHeight',5,'MinPeakProminence',5);
peak_mz_neg    = edge_mean_neg(locs);
[pks_sorted_neg,sortid_neg] = sort(pks,'descend');
mz_sorted_neg = peak_mz_neg(sortid_neg);

for k = 1:length(shifts)
    shiftx = shifts(k);    
    delta = min(abs(peak_mz_pos - shiftx));  
    if delta < 0.003
       Adduct_Selection(k,2) = 1;
    else
       Adduct_Selection(k,2) = 0;       
    end
end

%%%
grp_counts_pos = get_group_counts(shifts,group,mz_sorted_pos,pks_sorted_pos);
grp_counts_neg = get_group_counts(shifts,group,mz_sorted_neg,pks_sorted_neg);
total_group_counts = grp_counts_pos + grp_counts_neg;

%plots
figure(1)
pie(total_group_counts./sum(total_group_counts),{'Reactions','Adducts','Natural Isotope Abundance'})

figure(2)
subplot(1,2,1)
bar(pks_sorted_pos(1:10))
xticks(1:10)
xticklabels(round(mz_sorted_pos(1:10),3))
ylabel('Frequency')
xlabel('Neutral Loss')

subplot(1,2,2)
bar(pks_sorted_neg(1:10))
xticks(1:10)
xticklabels(round(mz_sorted_neg(1:10),3))
ylabel('Frequency')
xlabel('Neutral Loss')

figure(3)
subplot(1,2,1)
plot(edge_mean_pos,Ncorrected_pos,'b')
hold on
vline(shifts,'r--')

subplot(1,2,2)
plot(edge_mean_neg,Ncorrected_neg,'b')
hold on
vline(shifts,'r--')

function [all_diff,N,edges,edge_mean,Ncorrected] = get_differences(DAT)

all_diff = [];
for k = 1:160
    Explanation = {};
    Massdiff = [];
    matching = [];
    explanation = {};   
    %get outlier masses
    id              = DAT.col == k;
    mz              = DAT.mzx(id);
    int             = DAT.intx(id);      
    dmz             = mz - mz';
    dmz_triu        = abs(triu(dmz));
    dmzx            = dmz_triu(:);
    dmzx(dmzx == 0) = []; 
    all_diff = vertcat(all_diff,dmzx);
end
[N,edges] = histcounts(all_diff,1000000);
edge_mean = zeros(length(edges)-1,1);
parfor k = 2:length(edges)
    edge_mean(k-1,1) = mean([edges(k-1),edges(k)]);
end

baselineY = sgolayfilt(N,5,10001);
Ncorrected = N-baselineY;

end





function [grp_counts] = get_group_counts(shift,group,mz_sorted,pks_sorted)
for k = 1:length(shift)
    shiftx = shift(k);
    [delta,posx] = min(abs(shiftx - mz_sorted));
    if delta < 0.003
        INT(k,1) = round(pks_sorted(posx),0);
        GROUP{k,1} = group{k};
    else
        INT(k,1) = 0;
        GROUP{k,1} = group{k};
    end
end
unique_groups = unique(GROUP);

for k = 1:length(unique_groups)
    ug = unique_groups(k);
    idx = find(strcmp(ug, GROUP));
    grp_counts(k) = sum(INT(idx));
end
end