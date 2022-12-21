[files, path] = uigetfile('*.mat','MultiSelect', 'on');
RTs = [18,46,108,100,0,65,114,71,106,124,73,96,45,62,93,111,28,114,26,59];
label = {'4HBA','Ade','Arg','Asp','ATP','Cyt','Dap','Folate','G3P','Ga6P','GlcNAc','GSH','Hxn','Ino','Mal','Orni','Panto','S7P','Suc','VitB2'};

for z = 6:length(RTs)
fia_data(1).mz    = [];
fia_data(2).mz    = [];
fia_data(1).int   = [];
fia_data(2).int   = [];
fia_data(1).files = [];
fia_data(2).files = [];
rt = RTs(z);
for n = 1:length(files)
M = load(files{n});

idx1 = strfind(files{n},'neg');
idx2 = strfind(files{n},'pos');


range = rt-3:rt+3;
if isempty(idx1)
    int = M.int;
    mz  = M.mz_x;
    int = mean(int(range,:));
    fia_data(1).mz  = mz';
    fia_data(1).int = vertcat(fia_data(1).int,int);
    fia_data(1).files = vertcat(fia_data(1).files,files(n));
else
    int = M.int;
    mz  = M.mz_x;
    int = mean(int(range,:));
    fia_data(2).mz  = mz';
    fia_data(2).int = vertcat(fia_data(2).int,int);
    fia_data(2).files = vertcat(fia_data(2).files,files(n));
end
end

cluster_full
save(label{z},'fia_data','rt','-v7.3')
clear fia_data
end