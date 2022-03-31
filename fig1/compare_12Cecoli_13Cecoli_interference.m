load db_ecoli1_v5
out = CountC(db_ecoli.Var3);
neutral_mass13 = db_ecoli.Var4 + out.' * 1.003355;
neutral_mass12 = db_ecoli.Var4;

%remove isomers that have the same indices in 12C and 13C
lowid = find(neutral_mass12 < 50);
neutral_mass12(lowid) = [];
neutral_mass13(lowid) = [];
db_ecoli(lowid,:) = [];

[~,ia] = unique(neutral_mass12);
neutral_mass13 = neutral_mass13(ia);
neutral_mass12 = neutral_mass12(ia);
db_ecoli       = db_ecoli(ia,:);

[~,ia] = unique(neutral_mass13);
neutral_mass13 = neutral_mass13(ia);
neutral_mass12 = neutral_mass12(ia);
db_ecoli       = db_ecoli(ia,:);

neutral_mass13(out==0) = [];
neutral_mass12(out==0) = [];
db_ecoli(out==0,:) = [];


neutral_mass12 = round(neutral_mass12,4);
neutral_mass12_lb = neutral_mass12 - 0.005;
neutral_mass12_ub = neutral_mass12 + 0.005;

neutral_mass13 = round(neutral_mass13,4);
neutral_mass13_lb = neutral_mass13 - 0.003;
neutral_mass13_ub = neutral_mass13 + 0.003;

for k = 1:length(neutral_mass12)
    for kk = 1:length(neutral_mass13)
        range1 = neutral_mass12_lb(k):0.00001:neutral_mass12_ub(k); 
        range2 = neutral_mass13_lb(kk):0.00001:neutral_mass13_ub(kk);

        incept = intersect(range1,range2);
        
        if isempty(incept)
            R(k,kk) = 0;
        else
            R(k,kk) = 1; 
            Lengthx(k,kk) = length(incept)*0.00001;
        end
    end
end

met = db_ecoli.Var5;
[row,col] = find(R);
met1 = met(row);
met2 = met(col);
A = [met1,met2];

