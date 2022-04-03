[out1, out2] = xlsread('Supplements2.xlsx','Results_hmdb');


files = out2(2:length(out2),1);
mode = out2(2:length(out2),5);
mets = out2(2:length(out2),6);

standard_mass   = out1(:,1);
num_nodes       = out1(:,2);
num_cluster     = out1(:,3);
node_mass       = out1(:,6);
clustersize     = out1(:,7);
cluster_id      = out1(:,8);
node_degree     = out1(:,9);


modes = {'pos','neg'};
%separate in pos and neg mode data

files_total = {};
std_mass_total = [];
node_mass_total = [];
out = [];

for jj = 1:length(modes)

idx = find(strcmp(modes{jj},mode));

files_pos        = files(idx);
mets_pos         = mets(idx);
std_mass_pos     = standard_mass(idx);  
num_nodes_pos    = num_nodes(idx);      
num_cluster_pos  = num_cluster(idx);    
node_mass_pos    = node_mass(idx); 
clust_size_pos   = clustersize(idx);
clust_id_pos     = cluster_id(idx);  
node_degree_pos  = node_degree(idx);

occurance        = groupcounts(files_pos);
%filter out files that only appear once (either spikein peak or
%interference but not possible to distinguish)
filterout  = find(occurance == 1);
filterout2 = find(isnan(std_mass_pos));
filterout = unique(vertcat(filterout,filterout2));


files_pos(filterout) = [];
[files_pos_unique,ia] = unique(files_pos);
std_mass_pos(filterout) = [];
node_mass_pos(filterout) = [];

OUT = zeros(length(files_pos_unique),1);

for k = 1:length(files_pos_unique)
    
    filex = files_pos_unique{k};
    ids   = strcmp(filex,files_pos);
    
    %get max node degree
    degree               = node_degree_pos(ids);
    [max_degree,posx]    = max(degree);
    multiple_max_degrees = max_degree == degree; %test if there are multiple nodes with the same degree
    if sum(multiple_max_degrees) > 1 %if yes
       %then test if among those there is one with a bigger network 
       clust_size            = clust_size_pos(multiple_max_degrees);
       [max_size,posx1]     = max(clust_size);
       multiple_max_nets  = max_size == clust_size; %test if there are multiple nodes with the same networksize
       if sum(multiple_max_nets) > 1
           %leave it at zero
       else
          idx = find(ids);
          idx1 = find(multiple_max_degrees);
          idx2 = find(multiple_max_nets);
          idx3 = idx(idx2);
          OUT(idx3,1) = 1;
       end
    else %if there is only one with max degree
       idx = find(ids);
       idx1 = find(multiple_max_degrees);
       idx2 = idx(idx1);
       OUT(idx2,1) = 1;
    end
end

node_mass_total = vertcat(node_mass_total,node_mass_pos);
std_mass_total  = vertcat(std_mass_total,std_mass_pos);
out             = vertcat(out,OUT);
end

x = node_mass_total(logical(out)) == std_mass_total(logical(out));
y = node_mass_total(~logical(out)) ~= std_mass_total(~logical(out));

TP = sum(x);
FP = sum(~x);
FN = sum(~y);
TN = sum(y);
TPR = TP/(TP + FN);
TNR = TN/(TN + FP);

accuracy = (TP+TN)/(TP+FP+FN+TN);
precision = TP/(TP+FP);
specificity = TN/(TN+FP);
recall   = TP/(TP+ FN);

balanced_acc = (TPR+TNR)/2;


