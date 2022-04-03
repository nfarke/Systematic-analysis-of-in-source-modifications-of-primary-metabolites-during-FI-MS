import numpy as np
import networkx as nx
import pandas as pd
import pickle
import pdb
import matplotlib.pyplot as plt

with open('Results_posHhmdb_01', 'rb') as handle:
    pos_mode_data = pickle.load(handle)

with open('Results_negHhmdb_01', 'rb') as handle:
    neg_mode_data = pickle.load(handle)
    
df      = pd.read_excel('Supplements2.xlsx','Sheet3')
files = df["FILES"].tolist()
mass  = df["Mass"].tolist()
kegg  = df["KEGG"].tolist()

df            = pd.read_excel('Supplements2.xlsx','Database')
Compounds     = df["Abbr"].tolist()
pos_mass      = df["Pos_Mass"].tolist()
neg_mass      = df["Neg_Mass"].tolist()


#positive mode
Results = {'file':[],'standard_mass':[],'node_mass':[],'num_cluster':[],'size_cluster':[],'met':[],
               'dmz':[],'Cluster_ID':[],'num_nodes':[],'mode':[]
               ,'degree':[]}

cluster_size = []
comps = pos_mode_data['components']
metmass = pos_mode_data['met_mass']
tol = 0.003

for k, groups in enumerate(comps):  #loop through the different subgraphs

    for jx,cluster in enumerate(groups):
        cluster_size = []
        mets = []
        for nx,node in enumerate(cluster):
            
            delta = np.abs(node - pos_mass)
            index    = np.unravel_index(delta.argmin(), delta.shape)

            
            if delta[index] < tol:
                file = files[k]
                num_cluster = len(groups)
                size_cluster = len(cluster)
                met = Compounds[index[0]]
                num_nodes = pos_mode_data['num_nodes'][k]
                degree    = pos_mode_data['degree'][k][node]
                standard_mass = metmass[k]
                
                Results['file'].append(file)
                Results['num_cluster'].append(num_cluster)
                Results['size_cluster'].append(size_cluster)
                Results['met'].append(met)
                Results['dmz'].append(delta[index])
                Results['Cluster_ID'].append(jx)
                Results['num_nodes'].append(num_nodes)
                Results['mode'].append('pos')
                Results['degree'].append(degree)
                if len(standard_mass)== 0:
                   Results['standard_mass'].append(standard_mass)
                else:
                   Results['standard_mass'].append(standard_mass[0])
                
                Results['node_mass'].append(node)
                

cluster_size = []
comps = neg_mode_data['components']
metmass = neg_mode_data['met_mass']

for k, groups in enumerate(comps):  #loop through the different subgraphs

    for jx,cluster in enumerate(groups):
        cluster_size = []
        mets         = []
        for nx,node in enumerate(cluster):
            
            delta    = np.abs(node - neg_mass)
            index    = np.unravel_index(delta.argmin(), delta.shape)

            
            if delta[index] < tol:
                file          = files[k]
                num_cluster   = len(groups)
                size_cluster  = len(cluster)
                met           = Compounds[index[0]]
                num_nodes     = neg_mode_data['num_nodes'][k]
                degree        = neg_mode_data['degree'][k][node]
                standard_mass = metmass[k]
                
                Results['file'].append(file)
                Results['num_cluster'].append(num_cluster)
                Results['size_cluster'].append(size_cluster)
                Results['met'].append(met)
                Results['dmz'].append(delta[index])
                Results['Cluster_ID'].append(jx)
                Results['num_nodes'].append(num_nodes)
                Results['mode'].append('neg')
                Results['degree'].append(degree)
                if len(standard_mass)== 0:
                   Results['standard_mass'].append(standard_mass)
                else:
                   Results['standard_mass'].append(standard_mass[0])
                
                Results['node_mass'].append(node)