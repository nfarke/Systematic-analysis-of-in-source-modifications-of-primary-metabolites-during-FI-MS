load fia_data_MH

file = 'Arg';
%masses = 200.0085 - 1.0073;
%[masses] = xlsread('Supplements2','Chor');
masses = [173.1041, 195.0867, 131.0826, 271.0823];

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;


posx = find(strcmp(file,fia_data(1).file_abbr));

%for j = 59
posx = posx*3-2:posx*3;%posx*3-2:posx*3;

for k =1:length(masses)
    massx = masses(k); 
    subplot(1,4,k)
    plotfunction(mz,int_neg,mean(int_neg),massx-0.015,massx+0.015,posx,1:480,0,massx,'k') 
end
