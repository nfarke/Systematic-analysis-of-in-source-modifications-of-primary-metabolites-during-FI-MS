%plot from supplements
%plot % RSD in negative mode and positive mode
[out1,out2] = xlsread('Supplements','Fig1b');

%get pos error
pos_error = out1(1:160,10)*100;
pos_error_endo = out1(1:160,11)*100;
%get neg error
neg_error = out1(1:160,14)*100;
neg_error_endo = out1(1:160,15)*100;

errors = horzcat(pos_error,neg_error, pos_error_endo,neg_error_endo);

hold on
boxplot(errors,'symbol','')

r = 1.15 - 0.3*rand(160,1);
scatter(r,pos_error,10,'filled','b')
r = 2.15 - 0.3*rand(160,1);
scatter(r,neg_error,10,'filled','b')

r = 3.15 - 0.3*rand(160,1);
scatter(r,pos_error_endo,10,'filled','b')
r = 4.15 - 0.3*rand(160,1);
scatter(r,neg_error_endo,10,'filled','b')

ylim([0 1000])
hold on
%plot the mean
plot(mean(errors,'omitnan'),'dg')
set(gca,'yscale','log')
ylabel('RSD, (%)');
xticks([1,2,3,4])
xticklabels({'positive mode','negative mode','positive mode endogenous','negative mode endogenous'})

