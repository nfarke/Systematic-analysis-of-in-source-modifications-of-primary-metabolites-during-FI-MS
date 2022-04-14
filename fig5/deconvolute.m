
masses = xlsread('deconvolute.xlsx','purL');

[out1,out2] = xlsread('deconvolute.xlsx','standards');

[out3,out4] = xlsread('deconvolute.xlsx','label');

for k = 1:length(masses)
    massx = masses(k);
    [delta,posx] = min(abs(massx - out1(:,1)));
    if delta < 0.003
        idx = out1(posx,2);
        idx2 = find(out3 == idx);
        label = out4(idx2);  
        Result(k,1) = label;
    else
        Result(k,1) = {'nan'};
    end  
end


[uniqueXX, ~, J] = unique(Result);
occ = histc(J, 1:numel(uniqueXX));

for k = 1:length(uniqueXX)-1
    standard = uniqueXX{k};
    posx     =  find(strcmp(standard,out4));
    tot_num  = sum(out1(:,2) == posx);
    occ(k,2) = tot_num;
end


ratio = occ(:,1)./occ(:,2);
[ratio_sorted,sortid] = sort(ratio,'descend')

bar(ratio_sorted)
xticklabels(uniqueXX(sortid))
