import numpy as np
import networkx as nx
import pandas as pd
import pickle
import pdb
import matplotlib.pyplot as plt

with open('Results_posH', 'rb') as handle:
    pos_mode_data = pickle.load(handle)

with open('Results_negH', 'rb') as handle:
    neg_mode_data = pickle.load(handle)

num_nodes_tot = np.add(pos_mode_data['num_nodes'],neg_mode_data['num_nodes'])
files = np.array(pos_mode_data['file'])

ClusterSize_pos = []
Degree_pos      = []
comps = pos_mode_data['components']
for k, groups in enumerate(comps):  #loop through the samples
       
    met_mass = pos_mode_data['met_mass'][k]
    if len(met_mass) > 0:
       for jx, cluster in enumerate(groups): #loop through the subnetworks
           if met_mass[0] in cluster: #if we find the single deprot mass, get number of nodes etc
              cluster_size =  len(cluster)
              ClusterSize_pos.append(cluster_size)
              Degree_pos.append(pos_mode_data['degree'][k][met_mass[0]])
    else:
       ClusterSize_pos.append(0)
       Degree_pos.append(-1)

       
ClusterSize_neg = []
Degree_neg = []
comps = neg_mode_data['components']
for k, groups in enumerate(comps):
    met_mass = neg_mode_data['met_mass'][k]
    if len(met_mass) > 0:
       for jx, cluster in enumerate(groups):
           if met_mass[0] in cluster:
              cluster_size =  len(cluster)
              ClusterSize_neg.append(cluster_size)
              Degree_neg.append(neg_mode_data['degree'][k][met_mass[0]])

    else:
       ClusterSize_neg.append(0)
       Degree_neg.append(-1)

#barplot
ClusterSize_tot = np.add(ClusterSize_pos,ClusterSize_neg)
files = np.array(pos_mode_data['file'])
sortid = np.argsort(num_nodes_tot)
sortid = np.flip(sortid)
tot_data = num_nodes_tot[sortid]
exp_data = ClusterSize_tot[sortid]
abbr     = files[sortid]
x  = np.arange(0,len(exp_data))   



