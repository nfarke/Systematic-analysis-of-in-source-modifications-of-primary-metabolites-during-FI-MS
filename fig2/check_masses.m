load fia_data_MH

file = 'UDPGlcNAc';
%masses = 651.32 + 1.0073;
[masses] = xlsread('Supplements2','Ga6P');

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;


posx = find(strcmp(file,fia_data(1).file_abbr));

for j = 59
posx = j*3-2:j*3;%posx*3-2:posx*3;

figure(j)
for k =1:length(masses(1))
    massx = masses(k); 
    subplot(2,3,k)
    plotfunction(mz,int_pos,mean(int_pos),massx-0.015,massx+0.015,posx,1:480,0,massx,'k') 
end

end