load Outlier_data
[out1,out2] = xlsread('Supplements2','Literature_MassShifts');
shifts = out1(:,1);
group = out2(2:end,1);
label = out2(2:end,2);

total.col  = vertcat(POS.col,  NEG.col);
total.row  = vertcat(POS.row,  NEG.row);
total.mzx  = vertcat(POS.mzx,  NEG.mzx);
total.intx = vertcat(POS.intx, NEG.intx);

[dmz,N,edges,edge_mean,Ncorrected] = get_differences(total);

%positive mode
[pks,locs] = findpeaks(Ncorrected,'MinPeakHeight',10,'MinPeakProminence',10);
peak_mz    = edge_mean(locs);
[pks_sorted,sortid] = sort(pks,'descend');
mz_sorted = peak_mz(sortid);

for k = 1:length(shifts)
    shiftx = shifts(k);    
    delta = min(abs(peak_mz - shiftx));  
    if delta < 0.003
       Adduct_Selection(k,1) = 1;
       value(k,1)            = shiftx;
    else
       Adduct_Selection(k,1) = 0;
       value(k,1)            = shiftx;
    end
end
shifts = shifts(find(Adduct_Selection));
group  = group(find(Adduct_Selection));
label  = label(find(Adduct_Selection));

figure(1)
%subplot(1,2,1)
bar(pks_sorted(1:30))
xticks(1:30)
xticklabels(round(mz_sorted(1:30),3))
ylabel('Frequency')
xlabel('Neutral Loss')

% figure(3)
% subplot(1,2,1)
% plot(edge_mean,N,'b')
% hold on
% vline(shifts,'r--')

figure(2)
plot(edge_mean,N,'b')
hold on

y = ones(length(shifts),1)*100;
for k = 1:length(shifts)
    %text(shifts(k),1500,group{k})
    text(shifts(k),1500,label{k})
    
    hold on
    if strcmp(group{k},'a')
       vline(shifts(k),'r')
       hold on
    elseif strcmp(group{k},'b')
       vline(shifts(k),'g')
       hold on
    else
       vline(shifts(k),'k')
       hold on
    end
end
xlim([0 105])

for k = 1:10
    text(mz_sorted(k),1300,num2str(mz_sorted(k)))  
end


