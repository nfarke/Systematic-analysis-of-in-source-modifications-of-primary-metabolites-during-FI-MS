load Outlier_data
load fia_data_MH
abbr = fia_data(1).file_abbr;
[out1,out2] = xlsread('Supplements2','Literature_MassShifts_truncated');
[out1x,out2x] = xlsread('Supplements2','Analytical_Standards');
abbrx = out2x(2:161,3);
class = out2x(2:161,11);

for k = 1:length(abbr)
    idx(k) = find(strcmp(abbr{k},abbrx));  
end
class = class(idx);


shifts = out1(:,1);
group = out2(2:end,1);
label = out2(2:end,2);

Results_neg = zeros(160,51);
for k = 1:160
    counts = [];
    col = [];
    
    explanation = {};   
    %get outlier masses
    id              = NEG.col == k;
    mz              = NEG.mzx(id);
    int             = NEG.intx(id);      
    dmz             = mz - mz';
    dmz_triu        = abs(triu(dmz));
    dmzx            = dmz_triu(:);

    Delta = abs(dmzx - shifts');
    [row,col]= find(Delta<0.003);
    
    if ~isempty(col)
        c = unique(col); % the unique values in the A (1,2,3,4,5)    
        for i = 1:length(c)
            counts(i,1) = sum(col==c(i)); % number of times each unique value is repeated
        end
 
        Results_neg(k,c) = counts;
    end
end

Results_pos = zeros(160,51);
for k = 1:160
    counts = [];
    col = [];
    
    explanation = {};   
    %get outlier masses
    id              = POS.col == k;
    mz              = POS.mzx(id);
    int             = POS.intx(id);      
    dmz             = mz - mz';
    dmz_triu        = abs(triu(dmz));
    dmzx            = dmz_triu(:);

    Delta = abs(dmzx - shifts');
    [row,col]= find(Delta<0.003);
    
    if ~isempty(col)
        c = unique(col); % the unique values in the A (1,2,3,4,5)    
        for i = 1:length(c)
            counts(i,1) = sum(col==c(i)); % number of times each unique value is repeated
        end
 
        Results_pos(k,c) = counts;
    end
end

Results = Results_neg + Results_pos;




%remove fumarate an g3p because they containt too many features
abbr([51,53]) = [];
Results([51,53],:) = [];
class([51,53]) = [];

%%%%
unique_class = unique(class);

unique_class = unique_class([3,6,4,2,1,5]);

total = [];
for k = 1:length(unique_class)
    dummy = unique_class{k};
    idx   = strcmp(dummy,class);
    part  = sum(Results(idx,:)./sum(idx),1);
    total = vertcat(total,part);
end

total = total./sum(total)*100;

partx = total(1,:);
[sortx,sortid] = sort(partx,'ascend');
total = total(:,sortid);
label = label(sortid);

partx = total(6,:);
[sortx,sortid] = sort(partx,'descend');
total = total(:,sortid);
label = label(sortid);

figure(2)
bar(total','stacked')
legend(unique_class)
xticks(1:length(label))
xticklabels(label)
ylabel('fraction')

%%%%%%%%
total = [];
for k = 1:length(unique_class)
    dummy = unique_class{k};
    idx   = strcmp(dummy,class);
    part  = sum(Results(idx,:));
    total = vertcat(total,part);
end


figure(3)
total_classes = sum(total,2);

fractions = total_classes./sum(total_classes);
pie(fractions)
legend(unique_class)
