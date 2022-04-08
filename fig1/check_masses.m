load fia_data_MH
masses = 505.9885;

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;




posx = find(strcmp('ATP',fia_data(1).file_abbr));
posx = posx*3-2:posx*3;

figure(1)
for k =1:length(masses)
    massx = masses(k); 
    plotfunction3(mz,int_neg,massx-0.01,massx+0.01,posx,1:480) 
end