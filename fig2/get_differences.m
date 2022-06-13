function [all_diff,N,edges,edge_mean,Ncorrected] = get_differences(DAT)

all_diff = [];
for k = 1:160
    Explanation = {};
    Massdiff = [];
    matching = [];
    explanation = {};   
    %get outlier masses
    id              = DAT.col == k;
    mz              = DAT.mzx(id);
    int             = DAT.intx(id);      
    dmz             = mz - mz';
    dmz_triu        = abs(triu(dmz));
    dmzx            = dmz_triu(:);
    dmzx(dmzx == 0) = []; 
    all_diff = vertcat(all_diff,dmzx);
end
[N,edges] = histcounts(all_diff,500000);
edge_mean = zeros(length(edges)-1,1);
parfor k = 2:length(edges)
    edge_mean(k-1,1) = mean([edges(k-1),edges(k)]);
end

baselineY = sgolayfilt(N,5,10001);
Ncorrected = N-baselineY;
end




