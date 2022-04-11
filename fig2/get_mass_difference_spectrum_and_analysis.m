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
    delta = min(abs(peak_mz_neg - shiftx));  
    if delta < 0.003
       Adduct_Selection(k,2) = 1;
    else
       Adduct_Selection(k,2) = 0;       
    end
end

%%%

figure(1)
%subplot(1,2,1)
bar(pks_sorted_pos(1:10))
xticks(1:10)
xticklabels(round(mz_sorted_pos(1:10),3))
ylabel('Frequency')
xlabel('Neutral Loss')

figure(2)
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

figure(4)
plot(edge_mean_neg,Ncorrected_neg,'b')
hold on
vline(shifts,'r--')
y = ones(length(shifts),1)*100;
for k = 1:length(shifts)
    text(shifts(k),50,group{k})
    hold on
end
xlim([0 105])

for k = 1:10
    text(mz_sorted_neg(k),55,num2str(mz_sorted_neg(k)))  
end
