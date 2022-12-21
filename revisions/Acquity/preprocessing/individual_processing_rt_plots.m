
C = [
    [14/255, 104/255,135/255].*0.7;     %dunkles blau grün
    [0 172/255 220/255].*0.7;           % blau
    0 172/255 220/255;                  %hellblau
    211/255, 212/255,64/255;            %gelb
    253/255 184/255 19/255;             %orange-gelb
    241/255 90/255 34/255;              %roetliches orange
    182/255 35/255 103/255;             %dunkles rot
    [182/255 35/255 103/255].*0.7;    
    0 172/255 220/255;                  %hellblau
    182/255 35/255 103/255; %dunkles rot
    246/255 138/255 30/255; %orange
    0 166/255 81/255;       %green
    253/255 184/255 19/255; %orange-gelb
    202/255 219/255 42/255; %gelb   
    101/255 44/255 144/255; %violett  
    108/255 200/255 190/255;%tuerkis
    82/255 79/255 161/255;  %blau
    241/255 90/255 34/255;  %roetliches orange
    rand(86,3)
    ];




[files, path] = uigetfile('*.mat','MultiSelect', 'on');
mzcc = [135.054515000000;174.111696000000;133.037529000000;506.995774000000;111.043282000000;190.095378000000;441.139703000000;259.045727000000;221.089959000000;307.083829000000;132.089898000000;148.073580000000;290.040308000000;118.026630000000;376.138306000000];
label = {'Ade','Arg','Asp','ATP','Cyt','Dap','Folate','Ga6P','GlcNAc','GSH','Orni','Panto','S7P','Suc','VitB2'};
a=repmat(label,[3,1]);
a = reshape(a,[45,1]);

vals = reshape(1:45,[3,15]);

J = cell(15,45);
RT = cell(15,45);
INT = cell(15,45);
figure(2)
%parpool(15)
for j = 1:length(mzcc)
    disp(j)
    indx = vals(:,j);
    %subplot(3,5,j)
    mzx = mzcc(j);
    mzx = mzx - 1.0073;
    counter = 1;
    counter1 = 1;
    jx = [];
    [J,RT,INT] = functionx(files,j,J,RT,INT,mzx);    
   % for n = 1:length(files)
       % M = load(files{n}); 
        %[~,pos] = min(abs(M.mz_x - mzx));     
       % int = mean(M.int(:,pos-3:pos+3),2);  

       % J{j,n} = {repmat(j,[1 length(M.rt)])};
        %RT{j,n} = {M.rt};
        %INT{j,n} = {int};
        
        
        %if sum(counter == indx) == 1
        %   plot3(repmat(j,[1 length(M.rt)]),M.rt,int,'color',C(counter1,:))
       % else
        %   plot3(repmat(j,[1 length(M.rt)]),M.rt,int,'k') 
       % end
end

NEG_data.RT = RT;
NEG_data.INT = INT;
NEG_data.J = J;

save('NEG_data','NEG_data','-v7.3')



function [J,RT,INT] = functionx(files,j,J,RT,INT,mzx)    
parfor n = 1:length(files)
        M = load(files{n}); 
        [~,pos] = min(abs(M.mz_x - mzx));     
        int = mean(M.int(:,pos-3:pos+3),2);  

        J{j,n} = repmat(j,[1 length(M.rt)]);
        RT{j,n} = M.rt;
        INT{j,n} = int;
end
end