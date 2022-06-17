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

df      = pd.read_excel('Supplements2.xlsx','Sheet3')
files = df["FILES"].tolist()
mass  = df["Mass"].tolist()
kegg  = df["KEGG"].tolist()

df            = pd.read_excel('Supplements2.xlsx','Standard_pos_neg_mass')
abbr          = df["Abbr"].tolist() #formely Compound
pos_mass      = df["Pos_Mass"].tolist()
neg_mass      = df["Neg_Mass"].tolist()

num_nodes_tot = np.add(pos_mode_data['num_nodes'],neg_mode_data['num_nodes'])

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

   
plt.figure(1)         
plt.bar(x,tot_data,color = 'blue')
plt.bar(x,exp_data,color = 'red')        
plt.yscale('log',basey = 2)   
plt.ylim((0,10000))
plt.xticks(x,labels = abbr,rotation = 'vertical')
plt.show()

#plt.figure(6)
#outx = np.divide(exp_data,tot_data)
#outx[np.isnan(outx)] = []
#np.boxplot(outx)


#histogram node degreee pos
plt.figure(2)
plt.subplot(1,2,1)
plt.hist(Degree_neg, bins=30)
plt.show()

plt.subplot(1,2,2)
plt.hist(Degree_pos, bins=30)
plt.show()


#barplot path length
neg_mode_sorted = np.sort(neg_mode_data['path'])
neg_mode_sorted = np.flip(neg_mode_sorted)

pos_mode_sorted = np.sort(pos_mode_data['path'])
pos_mode_sorted = np.flip(pos_mode_sorted)



plt.figure(3)
plt.subplot(1,2,1)
boxplot_data = [neg_mode_sorted]
plt.boxplot(boxplot_data)
plt.yscale('log')
plt.show()

plt.subplot(1,2,2)
boxplot_data = [pos_mode_sorted]
plt.boxplot(boxplot_data)
plt.yscale('log')
plt.show()

