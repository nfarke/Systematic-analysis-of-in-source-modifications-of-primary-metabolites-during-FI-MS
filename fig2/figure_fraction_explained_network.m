
%insert tot and exp data from python file "analyse graphs with plots"
exp = [];
tot = [];
ratio = exp./tot;

r = 0.92 + (0.18) .* rand(160,1);

figure(1)
boxplot(ratio*100,'symbol','')
hold on
set(gca,'yscale','log')
hold on
scatter(r,ratio*100,20,'filled')
ylabel('Fraction of peaks explained')
