load Outlier_data

data_neg = NEG.intx;
data_pos = POS.intx;

figure(1)
subplot(1,2,1)
boxplot(data_neg,'symbol','')
hold on
r = 1.10 - 0.2*rand(length(data_neg),1);
scatter(r,data_neg,10,'filled','b')
set(gca,'yscale','log')
ylim([0.9*10^3 10^7])
ylabel('Feature intensity')

subplot(1,2,2)
boxplot(data_pos,'symbol','')
r = 1.10 - 0.2*rand(length(data_pos),1);
hold on
scatter(r,data_pos,10,'filled','b')
set(gca,'yscale','log')
ylim([0.9*10^3 10^7])
ylabel('Feature intensity')