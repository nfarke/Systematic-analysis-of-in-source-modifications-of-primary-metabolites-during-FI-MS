%load fiadata_purmep

%pos mode
mz        = fia_data(2).mz;
int       = fia_data(2).int;
FY_neg    = fia_data(2).FY;
FMZ_neg   = fia_data(2).FMZ;
CMZ_neg   = fia_data(2).CMZ;

%fill mzy
[row,col] = find(isnan(FY_neg));

for k = 1:length(CMZ_neg)
    cmz_val = CMZ_neg(k);
    FMZ_neg(k,:) = cmz_val;
    [~,posx]  = min(abs(mz - cmz_val));
    int_val   = int(:,posx);
    FY_neg(k,:) = int_val;   
end

%fia_data = rmfield(fia_data,'data_zscore');
fia_data(2).FY_filled = FY_neg;
fia_data(2).FMZ_filled = FMZ_neg;


%save('fiadata_purmep_1000x2','fia_data','-v7.3')
