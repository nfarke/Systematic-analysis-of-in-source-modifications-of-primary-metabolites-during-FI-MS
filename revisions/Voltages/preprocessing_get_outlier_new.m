load fia_data_AQ_Arg

zscoreCut = 3;
IntCut = 1000;

FY_pos  = fia_data(1).FY_filled;
FMZ_pos = fia_data(1).FMZ_filled;
FY_neg  = fia_data(2).FY_filled;
FMZ_neg = fia_data(2).FMZ_filled;

FY_pos_480  = fia_data(1).FY_filled_480;
FMZ_pos_480 = fia_data(1).FMZ_filled_480;
FY_neg_480  = fia_data(2).FY_filled_480;
FMZ_neg_480 = fia_data(2).FMZ_filled_480;

[NEG,POS] = getnegpos(FY_neg_480, FY_pos_480,FY_neg,FY_pos,zscoreCut,IntCut,FMZ_pos_480,FMZ_neg_480);

save('Outlier_data_AQ_Arg','POS','NEG','-v7.3')


function [NEG,POS] = getnegpos(FY_neg_480, FY_pos_480, FY_neg,FY_pos,zscoreCut,IntCut,FMZ_pos_480,FMZ_neg_480)

FY_pos_log = log(FY_pos_480);
FY_neg_log = log(FY_neg_480);

zscore_pos = zscore(FY_pos_log,[],2);
zscore_neg = zscore(FY_neg_log,[],2);

%get zscore outlier
zscore_pos_logical = zscore_pos > zscoreCut;
zscore_neg_logical = zscore_neg > zscoreCut;



[row_pos,col_pos] = find(zscore_pos_logical);
[row_neg,col_neg] = find(zscore_neg_logical);

NEG.row = [];
NEG.col = [];
NEG.mzx  = [];
NEG.intx = [];

POS.row = [];
POS.col = [];
POS.mzx  = [];
POS.intx = [];

for k = 1:length(row_pos) 
    rowx_pos = row_pos(k);
    colx_pos = col_pos(k);
  
    intx_pos = FY_pos_480(rowx_pos,colx_pos);
    mzx_pos  = FMZ_pos_480(rowx_pos,colx_pos);    
    
    if intx_pos > IntCut
       POS.row = vertcat(POS.row,rowx_pos);
       POS.col = vertcat(POS.col,colx_pos);
       POS.mzx  = vertcat(POS.mzx,mzx_pos);
       POS.intx = vertcat(POS.intx,intx_pos);
    end
end


for k = 1:length(row_neg)
    rowx_neg = row_neg(k);
    colx_neg = col_neg(k);   
    
    intx_neg = FY_neg_480(rowx_neg,colx_neg);
    mzx_neg  = FMZ_neg_480(rowx_neg,colx_neg);
   
    if intx_neg > IntCut
       NEG.row = vertcat(NEG.row,rowx_neg);
       NEG.col = vertcat(NEG.col,colx_neg);
       NEG.mzx  = vertcat(NEG.mzx,mzx_neg);
       NEG.intx = vertcat(NEG.intx,intx_neg);
    end   
end

end

