function [peakID, dmz] = annotate_x(cmz,int,ref_mass,tolerance)

%  peakID = [];
%  dmz    = [];
%  for k = 1:length(ref_mass)
% 
%      ref_massx = ref_mass(k);
%      absdmz = abs(ref_massx - cmz);
%      idx = find(absdmz < tolerance);
%      totdmz = ref_massx - cmz;
%      
%      if ~isempty(idx)
%      [inty,~] = max(int(idx,:),[],2);
%      
%      [~,posx] = max(inty);
%      idx = idx(posx);
%      dmzx  = totdmz(idx);
%      
%      peakID = vertcat(peakID,idx);
%      dmz    = vertcat(dmz,dmzx);
%      else
%      peakID = vertcat(peakID,0);
%      dmz    = vertcat(dmz,0);        
%      end     
% 
%  end

peakID = [];
dmz    = [];
for k = 1:length(ref_mass)
    ref_massx = ref_mass(k);
    absdmz = abs(ref_massx - cmz);
    totdmz = ref_massx - cmz;
    [val,idx] = min(absdmz);  
    
    if val <= tolerance
       dmzx  = totdmz(idx);
       peakID = vertcat(peakID,idx);
       dmz    = vertcat(dmz,dmzx);
    else
       dmzx  = totdmz(idx);
       idx   = 0;
       peakID = vertcat(peakID,idx);
       dmz    = vertcat(dmz,dmzx);
    end
end


end