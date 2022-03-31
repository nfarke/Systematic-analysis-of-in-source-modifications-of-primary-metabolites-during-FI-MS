
C12 = load('fiadata_12C');
C13 = load('fiadata_13C');

mz = C12.fia_data(1).mz;
int12pos = C12.fia_data(1).int;
int13pos = C13.fia_data(1).int;
int12neg = C12.fia_data(2).int;
int13neg = C13.fia_data(2).int;

keggx_pos = C12.fia_data(1).ann.annot.kegg_id;
keggx_neg = C12.fia_data(2).ann.annot.kegg_id;
met_pos = C12.fia_data(1).ann.annot.MetName;
met_neg = C12.fia_data(2).ann.annot.MetName;
refmass_pos = C12.fia_data(1).ann.annot.ref_mass;
refmass_neg = C12.fia_data(2).ann.annot.ref_mass;
mzall_pos = C12.fia_data(1).ann.mzall;
mzy_pos = C12.fia_data(1).ann.mzy;


keggx_pos13 = C13.fia_data(1).ann13.annot.kegg_id;
keggx_neg13 = C13.fia_data(2).ann13.annot.kegg_id;
met_pos13 = C13.fia_data(1).ann13.annot.MetName;
met_neg13 = C13.fia_data(2).ann13.annot.MetName;
refmass_pos13 = C13.fia_data(1).ann13.annot.ref_mass;
refmass_neg13 = C13.fia_data(2).ann13.annot.ref_mass;
mzall_pos13 = C13.fia_data(1).ann13.mzall;
mzy_pos13 = C13.fia_data(1).ann13.mzy;


[out1,out2] = xlsread('Supplements1','Analytical_Standards');
List = out2(2:161,8);

for k = 1:length(List)
   keggx = List{k};
    
   %search for keggid in 12C dataset
   idx = find(strcmp(keggx,keggx_pos));
   
   %search for kegg id in 13C dataset
   idx13 = find(strcmp(keggx,keggx_pos13));
  
   mass12 = refmass_pos(idx);       
   [~,posid] = min(abs(mz-mass12));
   int12in12_pos = int12pos(:,posid);
   int12in13_pos = int13pos(:,posid);

   mass13 = refmass_pos13(idx13);       
   [~,posid] = min(abs(mz-mass13));
   int13in12_pos = int12pos(:,posid);
   int13in13_pos = int13pos(:,posid);   
   
   
   avg12in12pos  = mean(int12in12_pos,'omitnan');
   avg12in13pos  = mean(int12in13_pos,'omitnan');
   avg13in12pos  = mean(int13in12_pos,'omitnan');
   avg13in13pos  = mean(int13in13_pos,'omitnan');
   

   
   score(k,1) = 0.5*(avg12in12pos - avg12in13pos)/avg12in12pos + 0.5*(avg13in13pos - avg13in12pos)/avg13in13pos;
   % if kegg wasnt found in both datasets, set to nan
   if isempty(idx) || isempty(idx13)
       score(k,1) = nan;
       HM_pos(k,1) = nan;
       HM_pos(k,2) = nan;
       HM_pos(k,3) = nan;
       HM_pos(k,4) = nan;
   else
       %store average intensities for HeatMap
       HM_pos(k,1) = avg12in12pos;
       HM_pos(k,2) = avg12in13pos;
       HM_pos(k,3) = avg13in12pos;
       HM_pos(k,4) = avg13in13pos;
   end
   
   %negative mode
   %search for keggid in 12C dataset
   idx = find(strcmp(keggx,keggx_neg));
   
   %search for kegg id in 13C dataset
   idx13 = find(strcmp(keggx,keggx_neg13));
  
   mass12 = refmass_neg(idx);       
   [~,posid] = min(abs(mz-mass12));
   int12in12_neg = int12neg(:,posid);
   int12in13_neg = int13neg(:,posid);

   mass13 = refmass_neg13(idx13);       
   [~,negid] = min(abs(mz-mass13));
   int13in12_neg = int12neg(:,negid);
   int13in13_neg = int13neg(:,negid);   
   
   
   avg12in12neg  = mean(int12in12_neg,'omitnan');
   avg12in13neg  = mean(int12in13_neg,'omitnan');
   avg13in12neg  = mean(int13in12_neg,'omitnan');
   avg13in13neg  = mean(int13in13_neg,'omitnan');
   
 
   
   score(k,2) = 0.5*(avg12in12neg - avg12in13neg)/avg12in12neg + 0.5*(avg13in13neg - avg13in12neg)/avg13in13neg;
   % if kegg wasnt found in both datasets, set to nan
   if isempty(idx) || isempty(idx13)
       score(k,2) = nan;
       HM_neg(k,1) = nan;
       HM_neg(k,2) = nan;
       HM_neg(k,3) = nan;
       HM_neg(k,4) = nan; 
   else
       HM_neg(k,1) = avg12in12neg;
       HM_neg(k,2) = avg12in13neg;
       HM_neg(k,3) = avg13in12neg;
       HM_neg(k,4) = avg13in13neg; 
   
   end   
    
  
end

%plot boxplot with individual scores
[SCORE,idx] = max(score');
SCORE(SCORE<0) = 0;
SCORE(isnan(SCORE)) = [];
figure(1)
boxplot(SCORE,'symbol','')
r = 1.08 - 0.16*rand(length(SCORE),1);
hold on
scatter(r,SCORE,20,'filled','b')
hold on
plot(mean(SCORE,'omitnan'),'dg')

%plot heatmap with the respective intensities

for k = 1:160
    if idx(k) == 1
    HM(k,:) = HM_pos(k,:);         
    else
    HM(k,:) = HM_neg(k,:);      
    end
    HM(k,:) = rescale(HM(k,:));
end

%plot heatmap
r = [240 135 5]/255;       %# start
w = [246 225 181]/255;     %# middle
b = [0 158 227]/255;       %# end
%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(r(i), w(i), 32);
    c2(:,i) = linspace(w(i), b(i), 32);
end
C2 = [c1(1:end-1,:);c2];

row_labels = {'12in12','13in12','12in13','13in13'};
col_labels = List;
nanid = find(isnan(HM(:,1)));
HM(nanid,:) = [];
col_labels(nanid)= [];
aaa = HeatMap(HM,'RowLabels',col_labels,'ColumnLabels',row_labels,'ColorMap',C2);%,'DisplayRange',13);



