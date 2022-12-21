load fia_data_AQ_Arg
%load Outlier_data

file = 'GSH_AQ';
masses = 174.1117 + 1.0073;


mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;


%posx = find(strcmp(file,fia_data(1).samples));

posx = 7:9;

for k =1:length(masses)
    figure(k)
    massx = masses(k); 
    plotfunction(mz,int_pos,mean(int_pos),massx-0.015,massx+0.015,posx,1:60,0,massx,'k') 
end

