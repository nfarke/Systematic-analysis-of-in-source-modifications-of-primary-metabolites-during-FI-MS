function [] = plotfunction(mz,intx,mu,mz_lb,mz_ub,highlight_sample,sample_ids,color_mean,peak,color)

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


plot(mz(1,lb_id:ub_id)',intx(sample_ids,lb_id:ub_id)'); %plot all

if color_mean == 1
hold on
plot(mz(:,lb_id:ub_id)',mu(:,lb_id:ub_id)','k','linewidth',2);
end


if highlight_sample ~= 0
hold on
plot(mz(1,lb_id:ub_id)',intx(highlight_sample,lb_id:ub_id)',color,'linewidth',1)
end


if ~isempty(peak) == 1 && (mz_lb < min(peak)) == 1 && (mz_ub > max(peak)) == 1
hold on

vline(peak,'k')
% plot([peak peak],[0 10^4],'k')
% hold on
% plot([peak-0.002 peak-0.002],[0 10^4],'k--')
% hold on
% plot([peak+0.002 peak+0.002],[0 10^4],'k--')
% hold on
% xticks([mz_lb peak mz_ub])
% xlim([mz_lb mz_ub])


%end

end

