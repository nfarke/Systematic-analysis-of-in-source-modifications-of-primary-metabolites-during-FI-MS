
import numpy as np
import networkx as nx
import pandas as pd
import pdb
import matplotlib.pyplot as plt
import pickle
import re
import h5py

def find_fragment_mass(k,mass,mode,masses,tol,q1,q3,kegg,kegg_mrm):
    
    if mode == 'POS':
       mass = mass + 1.0073
    else:
       mass = mass - 1.0073
    
    indx             = np.column_stack(np.where(kegg_mrm == kegg))
    fragment_masses  = q3[:,indx[:,1]][0]    
     
    delta1           = np.abs(fragment_masses - masses) < 0.100
    indx1             = np.column_stack(np.where(delta1))
    fragment_masses1  = masses[indx1[:,0]]   
    fragment_massesx  = np.unique(fragment_masses1)  
    
    return fragment_massesx

def find_interference_mass(standard_mass,mode,masses,tol):
    df            = pd.read_excel('Supplements2.xlsx','Database')
    abbr          = df["Abbr"].tolist() #formely Compound
    pos_mass      = df["Pos_Mass"].tolist()
    neg_mass      = df["Neg_Mass"].tolist()
    if mode == 'POS':
        
       other_masses = np.setdiff1d(masses,standard_mass)
       other_masses = other_masses.reshape(-1,1)
       pos_mass = np.array(pos_mass).reshape(-1,1)
       delta = np.abs(pos_mass - np.transpose(other_masses)) < tol
       indx  = np.column_stack(np.where(delta))
       
       inference_mass = other_masses[indx[:,1]]
    else:
       other_masses = np.setdiff1d(masses,standard_mass)
       other_masses = other_masses.reshape(-1,1)
       neg_mass = np.array(neg_mass).reshape(-1,1)
       
       delta = np.abs(neg_mass - np.transpose(other_masses)) < tol
       indx  = np.column_stack(np.where(delta))
       
       inference_mass = other_masses[indx[:,1]]
    
    inference_mass = np.round(inference_mass,4)
    return inference_mass



def find_standard_mass(masses,mode,tol,filenames):
    df            = pd.read_excel('Supplements2.xlsx','Standard_pos_neg_mass')
    abbr          = df["Abbr"].tolist() #formely Compound
    pos_mass      = df["Pos_Mass"].tolist()
    neg_mass      = df["Neg_Mass"].tolist()
    
    
    df      = pd.read_excel('Supplements2.xlsx','Sheet3')
    files = df["FILES"].tolist()
    idx   = abbr.index(filenames)
    if  masses.size < 1:
        ref_mass = []
        filex = []
    else:
        
        if mode == 'POS':
            delta = np.abs(masses - pos_mass[idx])
            delta_min = np.min(delta)
            if delta_min < tol:
               position = np.argmin(delta)   
               ref_mass = masses[position]
               filex    = abbr[idx]
            else:
               ref_mass = []
               filex    = []
        else:
            delta = np.abs(masses - neg_mass[idx])
            delta_min = np.min(delta)
            if delta_min < tol:
               position = np.argmin(delta)   
               ref_mass = masses[position]
               filex    = abbr[idx]
            else:
                ref_mass = []
                filex    = []
                
    return ref_mass,filex


def get_element_dict(compound):
  pattern = r"([A-Z][a-z]*)[0-9]*"
  elements = re.findall(pattern,compound)
  Count  = []
  index = []
  for k,ele in enumerate(elements):
     index.append(compound.index(ele))
  index.append(len(compound))
  for k,ele in enumerate(elements):
      length = len(ele)
      count = compound[index[k]+length:index[k+1]]
      Count.append(count)
      
  EleDict = dict(zip(elements, Count))
  return EleDict
   
def get_massshifts2(shifts):
    shifts1 = np.asarray(shifts["SHIFT"].tolist())
    shifts1 = shifts1.reshape(-1,1)
    expl    = shifts["Explanation"].tolist()
    
    
    all_shifts = shifts1
    all_expl   = np.array(expl).reshape(-1,1)
    return all_shifts, all_expl

df                 = pd.read_excel('MRM.xlsx','Sheet1')
modes_mrm          = df["mode"].tolist()
q1_mrm             = np.array(df["q1"].tolist())
q3_mrm             = np.array(df["q3"].tolist())
kegg_mrm           = np.array(df["kegg"].tolist())

###################################################
    
tol1     = 0.003 # assign edge
tol2     = 0.003 # find monoisotopic mass
tol3     = 0.003 #remove outlier peaks
mode    = 'POS'
df      = pd.read_excel('Supplements2.xlsx','Sheet3')
shifts  = pd.read_excel('Supplements2.xlsx','Literature_MassShifts_truncated')

POS = h5py.File('Outlier_data.mat','r')

if mode == 'POS':
   indices = [i for i, x in enumerate(modes_mrm) if x == 'POS']
   q1_mode = q1_mrm[indices].reshape(1,-1)
   q3_mode = q3_mrm[indices].reshape(1,-1)
   kegg_mode = kegg_mrm[indices].reshape(1,-1)
else:
   indices = [i for i, x in enumerate(modes_mrm) if x == 'NEG']
   q1_mode = q1_mrm[indices].reshape(1,-1)
   q3_mode = q3_mrm[indices].reshape(1,-1)
   kegg_mode = kegg_mrm[indices].reshape(1,-1)



all_shifts, all_expl = get_massshifts2(shifts)

files   = df["FILES"].tolist()
mass    = df["Mass"].tolist()
kegg    = df["KEGG"].tolist()
formula = df["Formula"].tolist()

col = POS.get(mode+'/col')
col = np.array(col).reshape(1,-1)

mz = POS.get(mode+'/mzx')
mz = np.array(mz).reshape(1,-1)

Results = {'file':[],'num_conn_comp':[],'num_nodes':[],'components':[],'degree':[],'path':[],'met':[],'met_mass':[]}
ResultsH = {'file':[],'num_conn_comp':[],'num_nodes':[],'components':[],'degree':[],'path':[],'met':[],'met_mass':[],'mrm_masses':[]}

for k, filenames in enumerate(files):
    print(k)
    index = k + 1
    idx = col == index
    mzx = np.reshape(mz[idx],(-1,1))

    mzx = mzx[mzx != 0]
    mzx = np.round(mzx,4)
    mzx = np.unique(mzx)
    
    masses = np.reshape(mzx,(-1,1))

    standard_mass,filex = find_standard_mass(masses,mode,tol2,filenames)
    inference_mass      = find_interference_mass(standard_mass,mode,masses,tol2)
    mrm_masses          = find_fragment_mass(k,mass[k],mode,masses,tol3,q1_mode,q3_mode,kegg[k],kegg_mode)       
    
    diag_mat = masses - np.transpose(masses)
    triu     = np.abs(np.triu(diag_mat))
    
    
    G = nx.Graph()
    H = nx.Graph()
    Edges = []
    color_map = []
    for jx,node in enumerate(masses):
        
        if node == standard_mass:
           color_map.append('red') 
        elif node in inference_mass:
           color_map.append('orange')
           a=1
        else:
           color_map.append('blue') 
                
        G.add_node(jx,mass = node[0], formula = {})
        H.add_node(node[0])
        #add compound name as label if it is in the database

    triu_ids = np.triu_indices_from(triu)
    rows = triu_ids[0]
    cols = triu_ids[1]
    for j,row_id in enumerate(rows):
        col_id = cols[j]
        if col_id > row_id:
           value = triu[row_id,col_id]
           value = np.abs(value)
           delta = np.abs(value - all_shifts)   #truncate all_shifts based on what is possible
           # take the starting nodes sum formula, 
           outs    = np.unravel_index(delta.argmin(), delta.shape)
           
           if delta[outs] < tol1:
              expl = all_expl[outs]
              start = row_id #masses[row_id][0]
              end  =  col_id #masses[col_id][0]
              G.add_edge(start,end,label = expl)
              H.add_edge(masses[start][0],masses[end][0], label = expl)
           
    
    path = nx.all_pairs_shortest_path(H)    
    all_paths = {x[0]:x[1] for x in path}
    if not standard_mass:
        pathlength = 0
    else:    
        pathlength = len(all_paths[standard_mass[0]])
    
    
    fig, axs = plt.subplots(1, 1, constrained_layout=True)
    fig.suptitle(filenames, fontsize=16)    
    pos=nx.spring_layout(G)
    nx.draw(G, pos, with_labels = False,node_size = 10,node_color = color_map) 
    nx.draw_networkx_labels(G,pos,nx.get_node_attributes(G,'mass'))                                                             
    nx.draw_networkx_edge_labels(G,pos,edge_labels=nx.get_edge_attributes(G,'label'))
    #plt.savefig(filenames+'.png')
    
    #Results['file'].append(filenames)
    #Results['num_conn_comp'].append(nx.number_connected_components(G))
    #Results['num_nodes'].append(nx.number_of_nodes(G))
    #Results['components'].append(list(nx.algorithms.components.connected_components(G)))
    #Results['degree'].append(nx.degree(G))
    #Results['path'].append(pathlength)
    #Results['met'].append(filex)
    #Results['met_mass'].append(standard_mass)

    ResultsH['file'].append(filenames)
    ResultsH['num_conn_comp'].append(nx.number_connected_components(H))
    ResultsH['num_nodes'].append(nx.number_of_nodes(H))
    ResultsH['components'].append(list(nx.algorithms.components.connected_components(H)))
    ResultsH['degree'].append(nx.degree(H))
    ResultsH['path'].append(pathlength)
    ResultsH['met'].append(filex)
    ResultsH['met_mass'].append(standard_mass)
    ResultsH['mrm_masses'].append(mrm_masses)
    

#with open('Results_negHhmdb_01', 'wb') as handle:
    #pickle.dump(ResultsH, handle, protocol=pickle.HIGHEST_PROTOCOL)

    
    
    
    
    
    
    
    
    
    
    
    
    