[out1,out2] = xlsread('Supplements1','Analytical_Standards');

pos_error = out1(1:160,18)*100;
pos_picked = out1(1:160,16);

neg_error = out1(1:160,25)*100;
neg_picked = out1(1:160,23);

pos_error(~pos_picked) = nan;
neg_error(~neg_picked) = nan;

errors = horzcat(pos_error,neg_error);

hold on
boxplot(errors,'symbol','')

r = 1.15 - 0.3*rand(160,1);
scatter(r,pos_error,10,'filled','b')
r = 2.15 - 0.3*rand(160,1);
scatter(r,neg_error,10,'filled','b')
ylim([0 100])
hold on
plot(mean(errors,'omitnan'),'dg')

set(gca,'yscale','log')
hold on


