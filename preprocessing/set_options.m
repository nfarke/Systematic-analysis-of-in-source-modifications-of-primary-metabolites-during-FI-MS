function [options] = set_options()
datex = date;
file_name = 'StandardsXXXX';
file_name = strcat(file_name,'_',datex);
%Options
%preprocessing
    backadj = 1; %on  %removes baseline
    smooth_span = 0; %20 % smoothing, 0 = off
    degree = 2;
    windowsize = 1;
    stepsize = 1;

%Annotation    
    Adduct_List_neg = {'[M-H]-'};%,'[M-3H]3-','[M-2H]2-','[M-H2O-H]-','[M+Na-2H]-','[M+Cl]-','[M+K-2H]-','[M+FA-H]-','[M+Hac-H]-','[M+Br]-','[M+TFA-H]-','[2M-H]-','[2M+FA-H]-','[2M+Hac-H]-','[3M-H]-'}; 
    Adduct_List_pos = {'[M+H]+'};%,'[M+3H]3+','[M+2H+Na]3+','[M+H+2Na]3+','[M+3Na]3+','[M+2H]2+','[M+H+NH4]2+','[M+H+Na]2+','[M+H+K]2+','[M+ACN+2H]2+','[M+2Na]2+','[M+2ACN+2H]2+','[M+3ACN+2H]2+','[M+NH4]+','[M+Na]+','[M+CH3OH+H]+','[M+K]+','[M+ACN+H]+','[M+2Na-H]+','[M+IsoProp+H]+','[M+ACN+Na]+','[M+2K-H]+','[M+2ACN+H]+','[M+IsoProp+Na+H]+','[2M+H]+','[2M+NH4]+','[2M+Na]+','[2M+K]+','[2M+ACN+H]+','[2M+ACN+Na]+'};
    tolerance = 0.003;

%select a database
k = 1;
db = {'ecoli_v5','ecoliXXX','ecoli2','Database','ecoli_dummy','StandardDB','CyanoDB'};

dbs = load(db{k});
fieldname = fieldnames(dbs);
dbx = getfield(dbs,fieldname{1});
data.kegg_id = dbx(:,2);
data.moldb_mono_mass = cell2mat(dbx(:,4));
data.name = dbx(:,1);
data.moldb_formal_charge = zeros(size(data.name));
data.abbr = dbx(:,5);

    
%Classical Peak Picking
HeightFilter = 750; 
MinPeakProminence = 300;
%Binning/Clustering
batch_size = 0.5;
cluster_cutoff = tolerance^2;

options.preprocessing.backadj = backadj;
options.preprocessing.smooth_span = smooth_span;
options.preprocessing.degree = degree;
options.preprocessing.windowsize = windowsize;
options.preprocessing.stepsize = stepsize;
options.Annotation.Adduct_List_neg = Adduct_List_neg;
options.Annotation.Adduct_List_pos = Adduct_List_pos;

options.Annotation.tolerance = tolerance;
options.ClassicalPeakPicking.HeightFilter = HeightFilter;
options.ClassicalPeakPicking.MinPeakProminence = MinPeakProminence;


options.BinningClustering.batch_size = batch_size;
options.BinningClustering.cluster_cutoff = cluster_cutoff;
options.database = data;
options.database_name = db{k};

options.file_name = file_name;
end

