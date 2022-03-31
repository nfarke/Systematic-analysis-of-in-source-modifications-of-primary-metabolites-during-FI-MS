function annotate_NF
global fia_data

options = set_options;
tolerance = options.Annotation.tolerance;
load('db_ecoli1_v5')

for mode = 1:2

    if mode == 1
        Adduct_List = options.Annotation.Adduct_List_pos;
    else
        Adduct_List = options.Annotation.Adduct_List_neg;
        clear empty_row;
    end
    
    neutral_mass = db_ecoli.Var4; % neutral (normal isotope)
    
    [ref_mass, MetName,kegg_id, abbr] = get_adduct_info(db_ecoli,Adduct_List,neutral_mass,mode);
    [peakID, dmz] = annotate_x(fia_data(mode).CMZ,fia_data(mode).FY,ref_mass,tolerance);
    
    annot = table(peakID,abbr,MetName,ref_mass,kegg_id,dmz);
    % Delete unidentified reference masses
    annot(annot.peakID==0,:) = [];
    
    [~, b] = sort(annot.kegg_id);
    
    fia_data(mode).ann.annot            = annot(b,:);
    fia_data(mode).ann.mzy              = fia_data(mode).FY(fia_data(mode).ann.annot.peakID,:);
    fia_data(mode).ann.mzall            = fia_data(mode).FMZ(fia_data(mode).ann.annot.peakID,:);
end   
end