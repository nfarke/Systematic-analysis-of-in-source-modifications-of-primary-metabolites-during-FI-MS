load Outlier_Panto
pos_outlier = POS.col;
neg_outlier = NEG.col;

%[N_neg,~] = histcounts(neg_outlier,660);
%[N_pos,~] = histcounts(pos_outlier,660);

Counts_neg = [];
for k = 1:60
    N_neg(k,1) = sum(neg_outlier == k);
    N_pos(k,1) = sum(pos_outlier == k);  
end

M1_ids = 1:20;

M1_pos = zeros(20,3);
M1_neg = zeros(20,3);
for k = 1:length(M1_ids)
    id = M1_ids(k);
    range = id*3-2:id*3;
    for ix = 1:length(range)
        rangex = range(ix);
        M1_pos(k,ix) = N_pos(rangex);
        M1_neg(k,ix) = N_neg(rangex);  
    end  
end