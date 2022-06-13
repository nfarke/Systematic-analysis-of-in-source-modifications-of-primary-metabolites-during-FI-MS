load Outlier_data

for k = 1:160   
    num_outlier(k,1) = sum(NEG.col == k) + sum(POS.col == k);    
end

r = 0.92 + (0.18).* rand(160,1);

figure(2)
boxplot(num_outlier,'symbol','')
hold on
set(gca,'yscale','log')
hold on
scatter(r,num_outlier,20,'filled')
ylim([0 10^4])
