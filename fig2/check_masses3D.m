load fia_data_MH

mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;

massx = 136.038531 + 1.0073;


posx = find(strcmp('Hxn',fia_data(1).file_abbr));
posx = posx*3-2:posx*3;

posx2 = find(strcmp('Ino',fia_data(1).file_abbr));
posx2 = posx2*3-2:posx2*3;

posx3 = find(strcmp('IMP',fia_data(1).file_abbr));
posx3 = posx3*3-2:posx3*3;

figure(1)
plotfunction3(mz,int_pos,massx-0.05,massx+0.05,[posx,posx2,posx3],1:480)
