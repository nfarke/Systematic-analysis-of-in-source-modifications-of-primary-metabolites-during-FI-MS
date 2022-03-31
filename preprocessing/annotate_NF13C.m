function annotate_NF13C
global fia_data

options = set_options;
tolerance = options.Annotation.tolerance;
load('db_ecoli1_v5')
%load('db_ecoli_Intermediates')


for mode = 1:2

    if mode == 1
        Adduct_List = options.Annotation.Adduct_List_pos;
    else
        Adduct_List = options.Annotation.Adduct_List_neg;
        clear empty_row;
    end
    
    neutral_mass = db_ecoli.Var4; % neutral (normal isotope)
    Ccount = CountC(db_ecoli.Var3);
    C13_mass = neutral_mass + Ccount' * 1.003355; % 13C

    [ref_mass, MetName,kegg_id, abbr] = get_adduct_info(db_ecoli,Adduct_List,C13_mass,mode);
    [peakID, dmz] = annotate_x(fia_data(mode).CMZ,fia_data(mode).FY,ref_mass,tolerance);
    
    annot = table(peakID,abbr,MetName,ref_mass,kegg_id,dmz);
    % Delete unidentified reference masses
    annot(annot.peakID==0,:) = [];
    Ccount(annot.peakID==0,:) = [];
    [~, b] = sort(annot.kegg_id);
    
    fia_data(mode).ann13.annot            = annot(b,:);
    fia_data(mode).ann13.mzy              = fia_data(mode).FY(fia_data(mode).ann13.annot.peakID,:);
    fia_data(mode).ann13.mzall            = fia_data(mode).FMZ(fia_data(mode).ann13.annot.peakID,:);
    fia_data(mode).ann13.Ccount           = Ccount;
end   
end