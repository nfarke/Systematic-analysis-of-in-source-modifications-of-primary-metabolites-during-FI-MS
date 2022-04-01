load fia_data_MH
[masses] = xlsread('Supplements2','G3P');

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;




posx = find(strcmp('G3P',fia_data(1).file_abbr));
posx = posx*3-2:posx*3;


for k =1:3:length(masses)
    disp(k)
    figure(k)
    massx = masses(k); 
    
    plotfunction(mz,int_pos,mean(int_pos),massx-1,massx+1,posx,1:480,0,massx,'k') 
    hold on
end