function [reference_mass, name,kegg_id, abbr] = get_adduct_info(data,Adduct_List,neutral_mass,mode)

H = 1.00728;
H2O = 15.994915;
Cl =  34.969402;
HCOO = 46.005479308;
CN = 26.0031;
Na = 22.9897697;

reference_mass = [];
name = {};
kegg_id = {};
abbr = {};

if mode == 2
    for k = 1:length(Adduct_List)
        n = char(Adduct_List{k});
        switch n
        case '[M]-'    
            reference_mass1 = neutral_mass;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M]-'));       
            
        case '[M-H]-'
            reference_mass1 = neutral_mass - H;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M-H]-'));

        case '[M-2H]2-'
            reference_mass1 = (neutral_mass - 2*H)/2;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M-2H]2-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M-2H]2-'));

        case '[M-3H]3-'
            reference_mass1 = (neutral_mass - 3*H)/3;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M-3H]3-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M-3H]3-'));

        case '[M-H2O-H]-'
            reference_mass1 = neutral_mass - 19.01839;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M-H2O-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M-H2O-H]-'));

        case '[M+Cl]-'
            reference_mass1 = neutral_mass + Cl;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+Cl]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+Cl]-'));

        case '[M+Na-2H]-'
            reference_mass1 = neutral_mass + 20.974666;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+Na-2H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+Na-2H]-'));

        case '[M+K-2H]-'
            reference_mass1 = neutral_mass + 36.948606;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+K-2H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+K-2H]-'));
        case '[M+Hac-H]-'
            reference_mass1 = neutral_mass + 59.013851;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+Hac-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+Hac-H]-'));
        case '[M+Br]-'
            reference_mass1 = neutral_mass + 78.918885;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+Br]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+Br]-'));
        case '[M+FA-H]-'
            reference_mass1 = neutral_mass + 44.998201;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+FA-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+FA-H]-'));                   
        case '[2M-H]-'
            reference_mass1 = 2*neutral_mass - H;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M-H]-'));
        case '[2M+FA-H]-'
            reference_mass1 = 2*neutral_mass + 44.998201;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+FA-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+FA-H]-'));                
        case '[2M+Hac-H]-'
            reference_mass1 = 2*neutral_mass + 59.013851;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+Hac-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+Hac-H]-'));
        case '[3M-H]-'
            reference_mass1 = 3*neutral_mass - H;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[3M-H]-'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[3M-H]-'));                 
        end
    end
else
    for k = 1:length(Adduct_List)
        n = char(Adduct_List(k));
        switch n
        
        case '[M]+'    
            reference_mass1 = neutral_mass;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M]+'));            
        case '[M+3H]3+'
            reference_mass1 = neutral_mass/3 + H;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+3H]3+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+3H]3+'));

        case '[M+2H+Na]3+'
            reference_mass1 = (neutral_mass + (Na+2*H))/3;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2H+Na]3+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2H+Na]3+'));
        case '[M+H+2Na]3+'
            reference_mass1 = (neutral_mass + (2*Na + H))/3;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+H+2Na]3+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+H+2Na]3+'));

        case '[M+2H]2+'
            reference_mass1 = (neutral_mass + 2*H)/2;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2H]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2H]2+'));

        case '[M+H+NH4]2+'
            reference_mass1 = neutral_mass/2 + 9.520550;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+H+NH4]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+H+NH4]2+'));

        case '[M+H+Na]2+'
            reference_mass1 = neutral_mass/2 + 11.998247;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+H+Na]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+H+Na]2+'));

        case '[M+H+K]2+'
            reference_mass1 = neutral_mass/2 + 19.985217;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+H+K]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+H+K]2+'));
        case '[M+ACN+2H]2+'
            reference_mass1 = neutral_mass/2 + 21.520550;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+ACN+2H]'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+ACN+2H]'));
        case '[M+2Na]2+'
            reference_mass1 = neutral_mass/2 + 22.989218;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2Na]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2Na]2+'));     
        case '[M+2ACN+2H]2+'
            reference_mass1 = neutral_mass/2 + 42.033823;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2ACN+2H]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2ACN+2H]2+')); 
        case '[M+3ACN+2H]2+'
            reference_mass1 = neutral_mass/2 + 62.547097;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+3ACN+2H]2+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+3ACN+2H]2+'));
        case '[M+H]+'
            reference_mass1 = neutral_mass + 1.007276;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+H]+'));                
        case '[M+NH4]+'
            reference_mass1 = neutral_mass + 18.033823;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+NH4]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+NH4]+'));
        case '[M+Na]+'
            reference_mass1 = neutral_mass + Na;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+Na]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+Na]+')); 
        case '[M+CH3OH+H]+'
            reference_mass1 = neutral_mass + 33.033489;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+CH3OH+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+CH3OH+H]+'));
        case '[M+K]+'
            reference_mass1 = neutral_mass + 38.963158;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+K]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+K]+'));
        case '[M+ACN+H]+'
            reference_mass1 = neutral_mass + 42.033823;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+ACN+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+ACN+H]+'));
        case '[M+2Na-H]+'
            reference_mass1 = neutral_mass + 44.971160;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2Na-H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2Na-H]+'));
        case '[M+IsoProp+H]+'
            reference_mass1 = neutral_mass + 61.06534;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+IsoProp+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+IsoProp+H]+'));
        case '[M+ACN+Na]+'
            reference_mass1 = neutral_mass + 64.015765;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+ACN+Na]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+ACN+Na]+'));
        case '[M+2K-H]+'
            reference_mass1 = neutral_mass + 76.919040;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2K-H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2K-H]+'));
        case '[M+2ACN+H]+'
            reference_mass1 = neutral_mass + 83.060370;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+2ACN+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+2ACN+H]+'));
        case '[M+IsoProp+Na+H]+'
            reference_mass1 = neutral_mass + 83.060370;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[M+IsoProp+Na+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[M+IsoProp+Na+H]+'));
        case '[2M+H]+'
            reference_mass1 = 2*neutral_mass + H;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+H]+')); 
        case '[2M+NH4]+'
            reference_mass1 = 2*neutral_mass + 18.033823;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+NH4]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+NH4]+'));                 
        case '[2M+Na]+'
            reference_mass1 = 2*neutral_mass + 22.989218;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+Na]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+Na]+'));                 
        case '[2M+K]+'
            reference_mass1 = 2*neutral_mass + 38.963158;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+K]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+K]+'));
        case '[2M+ACN+H]+'
            reference_mass1 = 2*neutral_mass + 42.033823;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+ACN+H]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+ACN+H]+'));
        case '[2M+ACN+Na]+'
            reference_mass1 = 2*neutral_mass + 64.015765;
            reference_mass = vertcat(reference_mass,reference_mass1);
            name = vertcat(name,strcat(data.Var1,'[2M+ACN+Na]+'));
            kegg_id = vertcat(kegg_id,data.Var2);
            abbr = vertcat(abbr,strcat(data.Var5,'[2M+ACN+Na]+'));                   
        end
    end
end
end

