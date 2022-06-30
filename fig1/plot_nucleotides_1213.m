
C12 = load('fiadata_12C');
C13 = load('fiadata_13C');

mz = C12.fia_data(1).mz;
int12pos = C12.fia_data(1).int;
int13pos = C13.fia_data(1).int;
int12neg = C12.fia_data(2).int;
int13neg = C13.fia_data(2).int;


load db_ecoli1_v5
load ecoli_v5

metnames = db_ecoli.Var1;
formula  = db_ecoli.Var3;
metmass  = db_ecoli.Var4;

List = {'ATP','CTP','UTP','GTP'};

for k = 1:length(List)
    metx = List{k};
    idx  = find(strcmp(metx,metnames));
    formx = formula(idx);
    numC  = CountC(formx);
    neutral_mass = metmass(idx);
    
    neg_mass12 = neutral_mass + 1.0073;
    neg_mass12 = neutral_mass - 1.0073;    
    neg_mass13 = neutral_mass + 1.0073 + numC*1.003355;
    neg_mass13 = neutral_mass - 1.0073 + numC*1.003355;
    
    %negitive mode
    figure('name',metx)
    subplot(1,2,1)
    plotfunction(mz,int12neg,mean(int12neg),neg_mass12-0.02,neg_mass12+0.02,1:5,1:5,0,neg_mass12,'k')
    hold on
    plotfunction(mz,int13neg,mean(int13neg),neg_mass12-0.02,neg_mass12+0.02,1:5,1:5,0,neg_mass12,'b')
    subplot(1,2,2)
    plotfunction(mz,int13neg,mean(int13neg),neg_mass13-0.02,neg_mass13+0.02,1:5,1:5,0,neg_mass13,'k')
    hold on
    plotfunction(mz,int12neg,mean(int12neg),neg_mass13-0.02,neg_mass13+0.02,1:5,1:5,0,neg_mass13,'b')
end