function Plot_MH()
[out1,out2] = xlsread('Supplements1','Analytical_Standards');
load fia_data_MH

abbr = out2(2:end,3);
neutral_mass = out1(1:160,10);
cnums = out2(2:161,8);
pref_mode = out1(1:160,29);
pos_mass = neutral_mass + 1.0073;
neg_mass = neutral_mass - 1.0073;

%positive  mode
mz = fia_data(1).mz;
int_neg = fia_data(2).int;
int_pos = fia_data(1).int;
file_abbr = fia_data(1).file_abbr;


mzy_neg = fia_data(2).ann.mzy;
mzall_neg = fia_data(2).ann.mzall;
cnum_neg = fia_data(2).ann.annot.kegg_id;
ref_mass_neg = fia_data(2).ann.annot.ref_mass - fia_data(2).ann.annot.dmz;

mzy_pos = fia_data(1).ann.mzy;
mzall_pos = fia_data(1).ann.mzall;
cnum_pos = fia_data(1).ann.annot.kegg_id;
ref_mass_pos = fia_data(1).ann.annot.ref_mass - fia_data(1).ann.annot.dmz;

for k =1:160
    disp(k)
    mass_pos = pos_mass(k);
    mass_neg = neg_mass(k);
    
    posid = find(strcmp(cnums{k},cnum_pos));
    negid = find(strcmp(cnums{k},cnum_neg));

    posx = find(strcmp(abbr{k},file_abbr));
    posx_indx = posx*3-2:posx*3;
    
    if pref_mode(k) == 1
    a=figure('Name',strcat(abbr{k},'__','POS'));
    else
    a=figure('Name',strcat(abbr{k},'__','NEG'));   
    end
    
    subplot(1,2,1)
    plotfunction(mz,int_neg,mean(int_neg),mass_neg - 0.02,mass_neg + 0.02,...
        posx_indx,1:480,0,mass_neg,'r')
    hold on
    scatter(mzall_neg(negid,:),mzy_neg(negid,:),15,'filled','b')
    hold on
    if ~isempty(negid)
    vline(ref_mass_neg(negid),'k--')
    end
    %scatter(mzX_neg,FX_neg,10,'filled','k')
    xlim([mass_neg - 0.02 mass_neg + 0.02])
    
    subplot(1,2,2)
    plotfunction(mz,int_pos,mean(int_pos),mass_pos - 0.02,mass_pos + 0.02,...
        posx_indx,1:480,0,mass_pos,'r')
    hold on
    scatter(mzall_pos(posid,:),mzy_pos(posid,:),20,'filled','b')
    hold on
    if ~isempty(posid)
    vline(ref_mass_pos(posid),'k--')
    end
    %scatter(mzX_pos,FX_pos,12,'filled','k')
    xlim([mass_pos - 0.02 mass_pos + 0.02])
    %saveas(a,strcat(abbr{k},'.jpg'));
end

end