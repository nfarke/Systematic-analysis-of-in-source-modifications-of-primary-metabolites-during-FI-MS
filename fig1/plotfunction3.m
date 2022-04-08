function [] = plotfunction3(mz,intx,mz_lb,mz_ub,highlight_sample,sample_ids)

%mz: 1 x n vector
%int m x n vector
%mz_lb 1 x 1 numeric value
%mz_ub 1 x 1 numeric value
%highlight_sample: sample_id 1 x 1 numeric value
%sample_ids: indices of sampled to be plottet  1 x k vector, 
%color_mean: 1 or 0
%peak: 1x1 numeric mz value. marks peak
mz_lb = mean(mz_lb);
mz_ub = mean(mz_ub);

id = find((mz_lb<mz & mz<mz_ub));
lb_id = min(id);
ub_id = max(id);


x = mz(1,lb_id:ub_id)';
y = intx(sample_ids,lb_id:ub_id)';
z = 1:size(intx,1);
z = ones(48,1) * z;

for k = 1:480
    if ~isempty(find(highlight_sample == k))
       plot3(z(:,k),x,y(:,k),'r'); %plot all 
       hold on
    else
       plot3(z(:,k),x,y(:,k),'k'); 
       hold on
    end      
end

end

