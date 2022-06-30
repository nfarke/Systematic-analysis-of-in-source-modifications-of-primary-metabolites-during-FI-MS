[out1,out2]  = xlsread('D:\QTOF\MethodPaper\fig1\Supplements','Fig3a');

figure(1)
boxplot(out1(:,2:3))
hold on

r = 0.92 + (0.18).* rand(160,1);
scatter(r,out1(:,2),20,'filled','k')

r = 1.92 + (0.18).* rand(160,1);
scatter(r,out1(:,3),20,'filled','k')

xticklabels({'single modifications','networks'})
ylabel('explained m/z features (%)')