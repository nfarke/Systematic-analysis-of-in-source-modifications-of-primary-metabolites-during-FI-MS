
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


[out1,out2] = xlsread('Supplements1','Analytical_Standards');
List = out2(2:161,8);

for k = 1:length(List)
    keggx = List{k};
    
   idx = find(strcmp(keggx,keggx_pos));
   met = met_pos(idx);
   mass = refmass_pos(idx);       
   [~,posid] = min(abs(mz-mass));
   int12_pos = int12pos(:,posid);
   int13_pos = int13pos(:,posid);

   avg12pos  = mean(int12_pos,'omitnan');
   avg13pos  = mean(int13_pos,'omitnan');
   score(k,1) = (avg12pos - avg13pos)/avg12pos;
   if isempty(idx)
       score(k,1) = nan;
   end
   
   idx = find(strcmp(keggx,keggx_neg));
   met = met_neg(idx);
   mass = refmass_neg(idx);       
   [~,posid] = min(abs(mz-mass));
   int12_neg = int12neg(:,posid);
   int13_neg = int13neg(:,posid);

   avg12neg  = mean(int12_neg,'omitnan');
   avg13neg  = mean(int13_neg,'omitnan');
   score(k,2) = (avg12neg - avg13neg)/avg12neg;           
   if isempty(idx)
       score(k,2) = nan;
   end    
end


SCORE = max(score');
SCORE(SCORE<0) = 0;

hold on
boxplot(SCORE)

r = 1.08 - 0.16*rand(160,1);
hold on
scatter(r,SCORE,20,'filled','b')
hold on
plot(mean(SCORE,'omitnan'),'dg')
%set(gca,'yscale','log')


