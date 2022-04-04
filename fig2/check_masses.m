load fia_data_MH
[masses] = xlsread('Supplements2','DAP');

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;




posx = find(strcmp('Dap',fia_data(1).file_abbr));
posx = posx*3-2:posx*3;

figure(1)
for k =1:length(masses)
    disp(k)
    subplot(2,3,k)
    massx = masses(k); 
    
    plotfunction(mz,int_pos,mean(int_pos),massx-0.01,massx+0.01,posx,1:480,0,massx,'k') 
    hold on
end