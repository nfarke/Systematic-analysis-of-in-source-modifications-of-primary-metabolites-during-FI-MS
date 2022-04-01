load Outlier_data.mat
load fia_data_MH
[out1,out2] = xlsread('Supplements2');

abbrx = out2(2:161,3);
class = out2(2:161,11);
kegg  = out2(2:161,8);
purity = out1(:,6);
mass   = out1(:,10);

abbr = fia_data(1).file_abbr;
%resort xls
for k = 1:length(abbr)
    id(k) = find(strcmp(abbr{k},abbrx));
end
purity = purity(id);
class  = class(id);
abbrx  = abbrx(id);
mass   = mass(id);
kegg   = kegg(id);

counts = check_interference(NEG,POS,abbrx,kegg);

histogram(counts,150,'BinWidth',0.5)




function counts = check_interference(NEG,POS,abbrx,kegg)

load db_ecoli1_v5
%database
neutral_masses = db_ecoli.Var4;
met_kegg = db_ecoli.Var2;
met_name = db_ecoli.Var5;
pos_masses = neutral_masses + 1.0073;

%remove isomers
[pos_masses,ia] = unique(pos_masses);
met_kegg = met_kegg(ia);
met_name = met_name(ia);


Results_name = {};
Results_mass = {};
for k = 1:length(abbrx)
   
    ABBR = abbrx{k};
    keggx = kegg{k};
    
    %get outlier masses
    %positive mode
    id_pos             = POS.col == k;
    mz_pos             = POS.mzx(id_pos);
    
    %get outlier masses
    %negative mode
    id_neg             = NEG.col == k;
    mz_neg             = NEG.mzx(id_neg);    
    
    delta_mz_pos  = abs(pos_masses - mz_pos');
    [row_pos,~] = find(delta_mz_pos < 0.003);
    %row is the metabolite in the database that is affected
    result_names_pos = met_name(row_pos);
    result_mass_pos  = pos_masses(row_pos);
    result_kegg_pos  = met_kegg(row_pos);
    
    [result_kegg_pos,ix]  = setdiff(result_kegg_pos,keggx);
    result_names_pos = result_names_pos(ix);
    result_mass_pos  = result_mass_pos(ix);

    %%%
    delta_mz_neg  = abs(pos_masses - mz_neg');
    [row_neg,~] = find(delta_mz_neg < 0.003);
    %row is the metabolite in the database that is affected
    result_names_neg = met_name(row_neg);
    result_mass_neg  = pos_masses(row_neg);
    result_kegg_neg  = met_kegg(row_neg);
    
    [result_kegg_neg,ix]  = setdiff(result_kegg_neg,keggx);
    result_names_neg = result_names_neg(ix);
    result_mass_neg  = result_mass_neg(ix);
    
    Results_name{k,1} = result_names_pos;
    Results_mass{k,1} = result_mass_pos;
    Results_kegg{k,1} = result_kegg_pos;    
    Results_name{k,2} = result_names_neg;
    Results_mass{k,2} = result_mass_neg;
    Results_kegg{k,2} = result_kegg_neg;
    
    counts(k,1) = length(result_mass_pos) + length(result_mass_neg);
end


end
