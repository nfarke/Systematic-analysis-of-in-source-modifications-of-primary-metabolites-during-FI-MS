M1 = load('Panto_AQ_01_pos.mat');
M2 = load('Panto_AQ_02_pos.mat');
M3 = load('Panto_AQ_03_pos.mat');

masstocharge = 148.0736;% [138.0317,135.0545,174.1117,133.0375,506.9958,111.0433,190.0954,441.1397,172.0137,259.0457,221.0900,307.0838,136.0385,268.0808,134.0215,132.0899,148.0736,290.0403,118.0266,376.1383];
mass = masstocharge + 1.0073;
%mass = horzcat(mass_neg,mass_pos);

for k = 1:3
    
if k == 1
   M = M1;
elseif k == 2
   M = M2;
elseif k == 3
   M = M3;
end
mz = mass;
mz_x = M.mz_x;
int = M.int;
rt  = M.rt;
[val,pos] = min(abs(mz_x - mz));
intx = mean(int(:,pos-5:pos+5),2);
plot(intx);
hold on

[valx, posx] = max(intx(10:end-10));
range = posx-5:posx+5;
range = range + 10;
disp(range(6))
end
