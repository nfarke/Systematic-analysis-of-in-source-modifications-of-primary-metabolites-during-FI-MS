load Outlier_data
load fia_data_MH
load db_ecoli1_v5
[out1,out2] = xlsread('Supplements2');
abbrx = out2(2:161,3);
kegg  = out2(2:161,8);

%get file abbreviations
abbr = fia_data(1).file_abbr;

%resort
for k = 1:length(abbr)
    id(k) = find(strcmp(abbr{k},abbrx));
end
class  = class(id);
abbrx  = abbrx(id);
kegg   = kegg(id);
%database
neutral_masses = db_ecoli.Var4;
met_kegg = db_ecoli.Var2;
met_name = db_ecoli.Var5;
pos_masses = neutral_masses + 1.0073;

%remove isomers
[pos_masses,ia] = unique(pos_masses);
met_kegg = met_kegg(ia);
met_name = met_name(ia);

%negative mode
neg_masses = pos_masses - 2*1.0073;


Results_name = {};
Results_mass = {};
Result_kegg  = {};

all_masses_neg = [];
all_masses_pos = [];
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
    [row_pos,col_pos] = find(delta_mz_pos < 0.003);
    %row is the metabolite in the database that is affected
    result_names_pos = met_name(row_pos);
    result_mass_pos  = pos_masses(row_pos);
    result_kegg_pos  = met_kegg(row_pos);
    
    [result_kegg_pos,ix]  = setdiff(result_kegg_pos,keggx);
    result_names_pos = result_names_pos(ix);
    result_mass_pos  = result_mass_pos(ix);

    %%%
    delta_mz_neg  = abs(neg_masses - mz_neg');
    [row_neg,col_neg] = find(delta_mz_neg < 0.003);
    %row is the metabolite in the database that is affected
    result_names_neg = met_name(row_neg);
    result_mass_neg  = neg_masses(row_neg);
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
    all_masses_neg = vertcat(all_masses_neg,result_mass_neg);
    all_masses_pos = vertcat(all_masses_pos,result_mass_pos);
    
    neg_count(k,1) = length(result_mass_neg);
    pos_count(k,1) = length(result_mass_pos);
end

histogram(counts,150)

figure(2)
[N1,edges] = histcounts(round(db_ecoli.Var4,0),4000);
idx = find(edges<1100);
N1 = N1(idx);

for k = 1:length(N1)
    mean_edges(k) = mean(edges(k)+edges(k+1));
end
bar(mean_edges,N1);

hold on
[N,edges] = histcounts(round(vertcat(all_masses_neg,all_masses_pos),0),length(mean_edges));
for k = 1:length(N)
    mean_edges1(k) = mean(edges(k)+edges(k+1));
end
rel_freq1 = N./max(N);
bar(mean_edges1,N);
xlim([50 1100])
xlabel('mass-to-charge ratio')
ylabel('relative frequency')
legend('distribution of database metabolite masses','distribution of interference masses')

figure(3)
pos_count = sum(pos_count);
neg_count = sum(neg_count);
tot = vertcat(pos_count,neg_count)./sum(pos_count,neg_count);
pie(tot)