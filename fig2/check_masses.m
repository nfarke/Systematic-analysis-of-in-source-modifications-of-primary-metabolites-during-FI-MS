load fia_data_MH

file = 'Dap';
[masses] = xlsread('Supplements2',file);

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;g


posx = find(strcmp(file,fia_data(1).file_abbr));
posx = posx*3-2:posx*3;

figure(1)
for k =1:length(masses)
    disp(k)
    subplot(2,3,k)
    massx = masses(k); 
    
    plotfunction(mz,int_pos,mean(int_pos),massx-0.015,massx+0.015,posx,1:480,0,massx,'k') 
    hold on
end