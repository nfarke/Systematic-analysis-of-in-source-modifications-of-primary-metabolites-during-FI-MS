load Panto

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

%average FMZ and FY
cntr = 1;
for k = 1:3:size(FY_neg,2)
    FY_neg1(:,cntr) = mean(FY_neg(:,k:k+2),2,'omitnan');
    FMZ_neg1(:,cntr) = mean(FMZ_neg(:,k:k+2),2,'omitnan'); 
    cntr = cntr + 1;   
end

%fia_data = rmfield(fia_data,'data_zscore');

fia_data(2).FY_filled = FY_neg1;
fia_data(2).FMZ_filled = FMZ_neg1;
fia_data(2).FY_filled_480 = FY_neg;
fia_data(2).FMZ_filled_480 = FMZ_neg;

save('Panto','fia_data','-v7.3')
