

exp = [];
tot = [];
ratio = exp./tot;

r = 0.92 + (0.18) .* rand(160,1);

figure(1)
boxplot(ratio,'symbol','')
hold on
set(gca,'yscale','log')
hold on
scatter(r,ratio,20,'filled')