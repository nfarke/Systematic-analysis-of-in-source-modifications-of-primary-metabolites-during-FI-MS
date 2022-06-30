load Outlier_data
load fia_data_MH
file_abbr = fia_data(1).file_abbr;

%Database entries
[out1,out2] = xlsread('Supplements2.xlsx','Database');
abbr = out2(2:end,1);
pos_mz = out1(:,2);
neg_mz = out1(:,3);

%get possible mass shifts from literature
[out1,out2] = xlsread('Supplements2.xlsx','Literature_MassShifts_truncated');
shifts = out1(:,1);
shifts = [shifts;-1*shifts];
category = out2(2:end,1);
explanation = out2(2:end,2);

%get standard mass
[out1,out2] = xlsread('Supplements2.xlsx','Standard_pos_neg_mass');
std_abbr   = out2(2:end,1);
std_pos_mz = out1(1:end,2);
std_neg_mz = out1(1:end,3);

%resort according to file abbr
for k = 1:length(file_abbr)
    abbrr = file_abbr(k);
    posx(k,1) = find(strcmp(abbrr,std_abbr));
end
std_abbr = std_abbr(posx);
std_pos_mz = std_pos_mz(posx);
std_neg_mz = std_neg_mz(posx);

for k = 1:length(file_abbr)
    if k == 151
        bla = 1;
    end
    idx = find(NEG.col == k);
    mzx_neg = NEG.mzx(idx);
    std_mass_neg = std_neg_mz(k);
    
    first_degree_masses = std_mass_neg + shifts;
    delta = abs(mzx_neg' - first_degree_masses);
    [row,col] = find(delta < 0.003);
    
    idx = find(POS.col == k);
    mzx_pos = POS.mzx(idx);
    std_mass_pos = std_pos_mz(k);
    
    first_degree_masses = std_mass_pos + shifts;
    delta = abs(mzx_pos' - first_degree_masses);
    [row_pos,col_pos] = find(delta < 0.003);   
      
    OUT(k,1) = length(unique(col)) + length(unique(col_pos));
    OUT(k,2) = length(mzx_neg) + length(mzx_pos);  
end

%calculate ratios for each spike-in sample
ratios = OUT(:,1)./OUT(:,2);
median_explained = median(ratios,'omitnan');
disp(median_explained)

%plot boxplot
r = 0.92 + (0.18) .* rand(160,1);
figure(1)
boxplot(ratios,'symbol','')
hold on
scatter(r,ratios,20,'filled','k')
ylabel('Fraction of Peaks explained by direct neighborhood')