load fia_data_AQ_Arg

mz        = fia_data(1).mz;
int       = fia_data(1).int;
FY_pos = fia_data(1).FY;
FMZ_pos = fia_data(1).FMZ;
CMZ_pos = fia_data(1).CMZ;

%fill mzy
[row,col] = find(isnan(FY_pos));

for k = 1:length(CMZ_pos)
    cmz_val = CMZ_pos(k);
    FMZ_pos(k,:) = cmz_val;
    [~,posx]  = min(abs(mz - cmz_val));
    int_val   = int(:,posx);
    FY_pos(k,:) = int_val;   
end

%average FMZ and FY
cntr = 1;
for k = 1:3:size(FY_pos,2)
    FY_pos1(:,cntr)  = mean(FY_pos(:,k:k+2),2,'omitnan');
    FMZ_pos1(:,cntr) = mean(FMZ_pos(:,k:k+2),2,'omitnan');    
    cntr = cntr + 1;   
end

fia_data(1).FY_filled   = FY_pos1;
fia_data(1).FMZ_filled  = FMZ_pos1;
fia_data(1).FY_filled_480 = FY_pos;
fia_data(1).FMZ_filled_480 = FMZ_pos;

save('fia_data_AQ_Arg','fia_data','-v7.3')
