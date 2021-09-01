#find the parameters for the cosinor model

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.optimize import curve_fit
from math import pi, cos

df=pd.read_csv('smFISH_BC.csv')
df1=pd.read_csv('smFISH_RC.csv')
bmal=df['Counts Bmal1']
cryBC=df['Counts Cry1']
nr1d1=df1['Counts Nr1d1']
mean_bmal=[]
mean_cryBC=[]
mean_nr1d1=[]
timeVec=[17.,21.,25.,29.,33.,37.,41.]
timeVec1=[21.,25.,29.,33.,37.,41.]

for i in range(len(timeVec)):
    mean_bmal.append(bmal.loc[(df['Time']==timeVec[i])].mean(axis=0))
    mean_cryBC.append(cryBC.loc[(df['Time']==timeVec[i])].mean(axis=0))
    
for i in range(len(timeVec1)):
    mean_nr1d1.append(nr1d1.loc[(df1['Time']==timeVec1[i])].mean(axis=0))


def cosinor(x,A0,A1,A2,phi_1,phi_2):                 
    w=2*pi/24.
    y=(A0/2. + A1*np.cos(w*x-phi_1) + A2*np.cos(2*w*x-phi_2))
    return y



popt_bmal, pcov_bmal =curve_fit(cosinor, timeVec,mean_bmal)

popt_cry, pcov_cry =curve_fit(cosinor, timeVec,mean_cryBC)

popt_nr1d1, pcov_nr1d1=curve_fit(cosinor, timeVec1,mean_nr1d1)

#popt_cry1, pcov_cry1 =curve_fit(cosinor, t,cry1)

print(popt_bmal, popt_cry, popt_nr1d1)

time=np.linspace(0,48,100)
pred_bmal=cosinor(time,*popt_bmal)
plt.plot(time, pred_bmal,c='r',label='bmal1')
plt.scatter(timeVec[1:],mean_bmal[1:], s=5,c='r')
plt.xlabel('time(hours)')
plt.ylabel('mRNA counts')
plt.title('smFISH cosinor fit to bmal1 mRNA')

#plt.figure()
pred_cry=cosinor(time,*popt_cry)
plt.plot(time, pred_cry, c='g', label='cry1')
plt.scatter(timeVec[1:],mean_cryBC[1:], s=5,c='g')
plt.xlabel('time(hours)')
plt.ylabel('mRNA counts')
plt.title('smFISH cosinor fit to cry1 mRNA')

#plt.figure()
pred_nr1d1=cosinor(time, *popt_nr1d1)
plt.plot(time,pred_nr1d1, c='b',label='nr1d1')
plt.scatter(timeVec1, mean_nr1d1, s=5, c='b')
plt.xlabel('time(hours)')
plt.ylabel('mRNA counts')
plt.title('smFISH cosinor fit to nr1d1 mRNA')
plt.legend()
