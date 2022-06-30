import numpy as np
import networkx as nx
import pandas as pd
import pickle
import pdb
import matplotlib.pyplot as plt

with open('Results_posH_hmdb', 'rb') as handle:
    pos_mode_data = pickle.load(handle)

with open('Results_negH_hmdb', 'rb') as handle:
    neg_mode_data = pickle.load(handle)

df      = pd.read_excel('Supplements2.xlsx','Sheet3')
files = df["FILES"].tolist()
mass  = df["Mass"].tolist()
kegg  = df["KEGG"].tolist()

df            = pd.read_excel('Supplements2.xlsx','Standard_pos_neg_mass')
abbr          = df["Abbr"].tolist() #formely Compound
pos_mass      = df["Pos_Mass"].tolist()
neg_mass      = df["Neg_Mass"].tolist()




num_nodes_tot = np.add(pos_mode_data['num_nodes'],neg_mode_data['num_nodes'])
num_nodes_neg = neg_mode_data['num_nodes']
num_nodes_pos = pos_mode_data['num_nodes']

ClusterSize_pos = []
Degree_pos      = []
comps = pos_mode_data['components']
for k, groups in enumerate(comps):  #loop through the samples
    met_mass = pos_mode_data['met_mass'][k]
    mrm_mass = pos_mode_data['mrm_masses'][k]
    tot_mass = np.concatenate((met_mass,mrm_mass))
    clustsize = []
    exclusion = []
    if len(tot_mass) > 0:
       for jx, cluster in enumerate(groups): #loop through the subnetworks
     
           for jjx,massx in enumerate(tot_mass):
               if massx in cluster and cluster not in exclusion:
                  clustsize.append(len(cluster))
                  exclusion.append(cluster)
                  break
              
                  
       totsize = np.sum(clustsize)
       ClusterSize_pos.append(totsize)
       Degree_pos.append(pos_mode_data['degree'][k][tot_mass[0]])
    
    else:
         ClusterSize_pos.append(0)
         Degree_pos.append(-1)

    
ClusterSize_neg = []
Degree_neg      = []
comps = neg_mode_data['components']
for k, groups in enumerate(comps):  #loop through the samples
    met_mass = neg_mode_data['met_mass'][k]
    mrm_mass = neg_mode_data['mrm_masses'][k]
    tot_mass = np.concatenate((met_mass,mrm_mass))
    clustsize = []
    exclusion = []
    if len(tot_mass) > 0:
       for jx, cluster in enumerate(groups): #loop through the subnetworks
     
           for jjx,massx in enumerate(tot_mass):
               if massx in cluster and cluster not in exclusion:
                  clustsize.append(len(cluster))
                  exclusion.append(cluster)
                  break
              
       totsize = np.sum(clustsize)
       ClusterSize_neg.append(totsize)
       Degree_neg.append(neg_mode_data['degree'][k][tot_mass[0]])
    
    else:
         ClusterSize_neg.append(0)
         Degree_neg.append(-1)


MassCount = []
for k, vals_pos in enumerate(pos_mode_data['mrm_masses']):
    
    vals_neg = neg_mode_data['mrm_masses'][k]
    MassCount.append(len(vals_pos)+len(vals_neg))

MassCount = np.array(MassCount)
idx = np.flip(np.argsort(MassCount))
mc  = MassCount[idx]
fx  = np.array(pos_mode_data['file'])[idx]

plt.figure(1)
plt.bar(np.arange(160),mc)
plt.xticks(np.arange(160), labels = fx, rotation = 'vertical')
plt.ylabel('Frequency')