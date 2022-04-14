load fiadata_purmep_900_500
[masses,out2] = xlsread('Supplements4','Sheet1');

files = fia_data(1).files;


for k = 1:length(files)
    filex{k,1} = files{k}(1:4);    
end


mode = out2(:,4);
genes = out2(:,1);


mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;

%posx = posx*3-2:posx*3;

figure(1)
for k = 1:length(masses)
    nexttile
    posx  = find(strcmp(genes{k},filex));
    massx = masses(k);
    metx  = out2(k,2);
    
    label = strcat(out2(k,1),'--',metx);
    if strcmp(mode(k),'neg')
       plotfunction(mz,int_neg,mean(int_neg),massx-0.02,massx+0.02,posx,1:9,0,massx,'r')
    else
       plotfunction(mz,int_pos,mean(int_pos),massx-0.02,massx+0.02,posx,1:9,0,massx,'r')        
    end
    title(label)
end
