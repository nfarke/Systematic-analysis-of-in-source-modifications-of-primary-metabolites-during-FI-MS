load Outlier_data

[out1,out2] = xlsread('Supplements2','Analytical_Standards');

standard_mass = out1(:,10);
keggid = out2(2:161,8);
abbr   = out2(2:161,3);

[out3,out4] = xlsread('MRM');
kegg_hmdb   = out4(:,2);
frag_mass   = out3(:,2);

[kegg_hmdb_unique,ids] = unique(kegg_hmdb,'stable');
kegg_intersection = intersect(kegg_hmdb_unique,keggid);




neg_data = NEG.mzx;
pos_data = POS.mzx;
total_data = vertcat(neg_data,pos_data);

[N,edges] = histcounts(total_data,200);
for k = 1:length(N)
    mean_edges2(k,1) = mean(edges(k:k+1));
end
bar(mean_edges2,N/max(N),'r')

hold on

[N2,edges2] = histcounts(frag_mass,200);
for k = 1:length(N2)
    mean_edges2(k,1) = mean(edges2(k:k+1));
end
bar(mean_edges2,N2/max(N2),'b')

xlim([0 1100])
xlabel('mass-to-charge ratio (m/z)')
ylabel('relative frequency')
legend('significant features','ms2 features')