rt_id = [46,108,100,1,65,114,71,124,73,96,111,28,114,26,59];
label = {'Ade','Arg','Asp','ATP','Cyt','Dap','Folate','Ga6P','GlcNAc','GSH','Orni','Panto','S7P','Suc','VitB2'};

load NEG_data
RT = NEG_data.RT;
INT = NEG_data.INT;
J = NEG_data.J;
vals = reshape(1:45,[3,15]);
load POS_data
RT_pos = POS_data.RT;
INT_pos = POS_data.INT;
J_pos = POS_data.J;

for k = 1:15
    for j = 1:45
        val(k,j) = max(INT{k,j});
        val_pos(k,j) = max(INT_pos{k,j});
    end
end

[maxval,maxid] = max(val');
[maxval2,maxid2] = max(val_pos');
valx = vertcat(maxval,maxval2);
[maxval,maxid] = max(valx);

for k = 1:15
    
    counter1 = 4;
    counter = 1;
    nexttile()
    indx = vals(:,k);
    for j = 1:45

        if sum(counter == indx) == 1
           plot(RT{k,j},INT{k,j}./maxval(k),'color','m','linewidth',1.5)
           hold on
           plot(RT_pos{k,j},INT_pos{k,j}./maxval(k),'c','linewidth',1.5)
           hold on
        else
           plot(RT{k,j},INT{k,j}./maxval(k),'color','k','linewidth',1.5)
           hold on
           plot(RT_pos{k,j},INT_pos{k,j}./maxval(k),'color','k','linewidth',1.5)
            hold on
        end 
        
        if rem(j/3,3) == 0
           counter1 = counter1 + 1; 
        end
        counter = counter + 1;
    end
    ylim([0 1.01]);
    vline(RT{k,j}(rt_id(k)),'k-')
    axis square
    xticks([0 60 120])
    xticklabels([0 1 2])
    xlabel('retention time (min)')
    ylabel('relative signal intensity')
    title(label(k))
    legend('positive','negative')
end




