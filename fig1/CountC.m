function [Ccount] = CountC(ecoli)
sumform = ecoli;
Ccount = [];
%loop through all metabolites (that contain C)
for k = 1:length(sumform)
    str=cell2mat(sumform(k));
    [EleList,~,EleEnd]=regexp(str,['[','A':'Z','][','a':'z',']?'],'match');
    [Num,NumStart]=regexp(str,'\d+','match');
    NumList=ones(size(EleList));
    Index=ismember(EleEnd+1,NumStart);
    NumList(Index)=cellfun(@str2num,Num);  
    Cid = find(ismember(EleList,'C'));
    if isempty(Cid)
    Ccount(k) = 0;
    else
    Ccount(k) = NumList(Cid);
    end

end