function [grp_counts] = get_group_counts(shift,group,mz_sorted,pks_sorted)
for k = 1:length(shift)
    shiftx = shift(k);
    [delta,posx] = min(abs(shiftx - mz_sorted));
    if delta < 0.003
        INT(k,1) = round(pks_sorted(posx),0);
        GROUP{k,1} = group{k};
    else
        INT(k,1) = 0;
        GROUP{k,1} = group{k};
    end
end
unique_groups = unique(GROUP);

for k = 1:length(unique_groups)
    ug = unique_groups(k);
    idx = find(strcmp(ug, GROUP));
    grp_counts(k) = sum(INT(idx));
end
end