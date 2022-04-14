%load fiadata_hispur

%pos mode
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

fia_data(1).FY_filled   = FY_pos;
fia_data(1).FMZ_filled  = FMZ_pos;

%save('fiadata_purmep','fia_data','-v7.3')
