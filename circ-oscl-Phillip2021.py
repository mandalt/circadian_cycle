#!/usr/bin/env python
# coding: utf-8

# In[2]:


#circadian oscillator with promoter switching
#telegtagh model of transcription, feedback loops are incorporated by Hill functions

import numpy as np
import matplotlib.pyplot as plt
from random import random
from math import log, cos, pi
import pandas as pd

#basal transcription rates, order=[bmal,cry,nrld]
am=[160.,190.,690.] 
#rate of protein synthesis
ap=10.                         
delta= log(2)/2
#rate of promoter deactivation, order=[bmal,cry,nrld] 
#koff=[11,9.6,4.9]                         
iter_t=400000
repeat=200
t=0
time=np.zeros((iter_t,repeat))

bmal_on=1.
bmal_off=1-bmal_on
bmal_mRNA=np.zeros((iter_t,repeat))
bmal_m=30
bmal_prtn=np.zeros((iter_t,repeat))
bmal_p=1000
cry_on=1.
cry_off=1-cry_on
cry_mRNA=np.zeros((iter_t,repeat))
cry_m=30
cry_prtn=np.zeros((iter_t,repeat))
cry_p=1000
nrld_on=1.
nrld_off=1-nrld_on
nrld_mRNA=np.zeros((iter_t,repeat))
nrld_m=30
nrld_prtn=np.zeros((iter_t,repeat))
nrld_p=1000
#burst frequency scale=1/mRNA half-life
#gamma=[0.109,0.254,0.0682] 
gamma=[0.142,0.306,0.0723]
A0=[57.71,21.71,48.81]
A1=[5.35,1.78,6.75]
A2=[-2.17,-0.43,2.85]
phi_1=[-1.64,1.18,-13.03]
phi_2=[1.16,-6.49,0.8]
#lambda for the homogenous Poisson process
#upper=[1.346218817970009, 1.1469191886793837, 0.7664797928367827]
upper=[1.7537896527682686, 1.3817215422672888, 0.8125584900601085]
#thinning events
R=[0,0,0]
#Protein threshold in Hill function
p0=1500.
#Hill coefficient
n=2.5

#the cosinor func.
def promoter(gama,A0,A1,A2,phi_1,phi_2,t):
    delta= log(2)/2                   
    w=2*pi/24.
    return delta*gama*(A0/2. + A1*cos(w*t-phi_1) + A2*cos(2*w*t-phi_2))



for j in range(repeat):
    bmal_on=1.
    bmal_off=0
    bmal_m=30.
    bmal_p=1000
    cry_on=1.
    cry_off=0
    cry_m=30.
    cry_p=1000.
    nrld_on=1.
    nrld_off=0
    nrld_m=30.
    nrld_p=1000.
    R=[0,0,0]
    t=0
    for i in range(iter_t):
        total=0
        k_on_bmal=promoter(gamma[0],A0[0],A1[0],A2[0],phi_1[0],phi_2[0],t)
        k_on_cry=promoter(gamma[1],A0[1],A1[1],A2[1],phi_1[1],phi_2[1],t)
        k_on_nrld=promoter(gamma[2],A0[2],A1[2],A2[2],phi_1[2],phi_2[2],t)
        #the hill fuctions for each gene
        x=am[0]*(1./(1+(nrld_p/p0)**n))
        y=am[1]*(1./(1+(p0/bmal_p)**n))*(1/(1+(cry_p/p0)**n))*(1/(1+(nrld_p/p0)**n))
        z=am[2]*(1./(1+(p0/bmal_p)**n))*(1/(1+(5*cry_p/p0)**n))
        #total = sum of the reaction propensities
        total_bmal=upper[0] + 11. + x*bmal_on + ap*bmal_m + delta*bmal_m + delta*bmal_p
        total_cry=upper[1] + 9.6 + y*cry_on + ap*cry_m + delta*cry_m + delta*cry_p
        total_nrld=upper[2] + 4.9 + z*nrld_on + ap*nrld_m + delta*nrld_m + delta*nrld_p
        total=total_bmal + total_cry + total_nrld
        r1=random()
        tau=(1/total)*log(1/r1)
        t+=tau
        time[i,j]=t+tau
        r2=random()
        if r2<k_on_bmal/total:
            bmal_on=1.
            bmal_off=0
        elif r2>=k_on_bmal/total and r2<(upper[0])/total:
            bmal_off=1.
            bmal_on=0
        elif r2>=upper[0]/total and r2<(upper[0]+11.)/total:
            bmal_off=1.
            bmal_on=0
            R[0]+=1
        elif r2>=(upper[0]+11.)/total and r2<(upper[0]+11.+x*bmal_on)/total:
            bmal_m+=1
        elif r2>=(upper[0]+11.+x*bmal_on)/total and r2<(upper[0]+11.+x*bmal_on+ap*bmal_m)/total:
            bmal_p+=1
        elif r2>=(upper[0]+11.+x*bmal_on+ap*bmal_m)/total and r2<(upper[0]+11.+x*bmal_on+ap*bmal_m+delta*bmal_m)/total:
            bmal_m-=1
        elif r2>=(upper[0]+11.+x*bmal_on+ap*bmal_m+delta*bmal_m)/total and r2<(total_bmal)/total:
            bmal_p-=1
        elif r2>=(total_bmal)/total and r2<(total_bmal+k_on_cry)/total:
            cry_on=1.
            cry_off=0
        elif r2>=(total_bmal+k_on_cry)/total and r2<(total_bmal+upper[1])/total:
            cry_off=1.
            cry_on=0
            R[1]+=1
        elif r2>=(total_bmal+upper[1])/total and r2<(total_bmal+upper[1]+9.6)/total:
            cry_off=1.
            cry_on=0
        elif r2>=(total_bmal+upper[1]+9.6)/total and r2<(total_bmal+upper[1]+9.6+y*cry_on)/total:
            cry_m+=1
        elif r2>=(total_bmal+upper[1]+9.6+y*cry_on)/total and r2<(total_bmal+upper[1]+9.6+y*cry_on+ap*cry_m)/total:
            cry_p+=1
        elif r2>=(total_bmal+upper[1]+9.6+y*cry_on+ap*cry_m)/total and r2<(total_bmal+upper[1]+9.6+y*cry_on+ap*cry_m+delta*cry_m)/total:
            cry_m-=1
        elif r2>=(total_bmal+upper[1]+9.6+y*cry_on+ap*cry_m+delta*cry_m)/total and r2<(total_bmal+total_cry)/total:
            cry_p-=1
        elif r2>=(total_bmal+total_cry)/total and r2<(total_bmal+total_cry+k_on_nrld)/total:
            nrld_on=1.
            nrld_off=0
        elif r2>=(total_bmal+total_cry+k_on_nrld)/total and r2<(total_bmal+total_cry+upper[2])/total:
            nrld_off=1.
            nrld_on=0
            R[2]+=1
        elif r2>=(total_bmal+total_cry+upper[2])/total and r2<(total_bmal+total_cry+upper[2]+4.9)/total:
            nrld_off=1.
            nrld_on=0
        elif r2>=(total_bmal+total_cry+upper[2]+4.9)/total and r2<(total_bmal+total_cry+upper[2]+4.9+z*nrld_on)/total:
            nrld_m+=1
        elif r2>=(total_bmal+total_cry+upper[2]+4.9+z*nrld_on)/total and r2<(total_bmal+total_cry+upper[2]+4.9+z*nrld_on+ap*nrld_m)/total:
            nrld_p+=1
        elif r2>=(total_bmal+total_cry+upper[2]+4.9+z*nrld_on+ap*nrld_m)/total and r2<(total_bmal+total_cry+upper[2]+4.9+z*nrld_on+ap*nrld_m+delta*nrld_m)/total:
            nrld_m-=1
        elif r2>=(total_bmal+total_cry+upper[2]+4.9+z*nrld_on+ap*nrld_m+delta*nrld_m)/total and r2<1.:
            nrld_p-=1
        bmal_mRNA[i,j]=bmal_m
        bmal_prtn[i,j]=bmal_p
        cry_mRNA[i,j]=cry_m
        cry_prtn[i,j]=cry_p
        nrld_mRNA[i,j]=nrld_m
        nrld_prtn[i,j]=nrld_p

print(R)
avg_bmal_p=bmal_prtn.sum(axis=1)/repeat
avg_cry_p=cry_prtn.sum(axis=1)/repeat
avg_nrld_p=nrld_prtn.sum(axis=1)/repeat
avg_bmal_m=bmal_mRNA.sum(axis=1)/repeat
avg_cry_m=cry_mRNA.sum(axis=1)/repeat
avg_nrld_m=nrld_mRNA.sum(axis=1)/repeat
avg_t=time.sum(axis=1)/repeat
plt.figure()
plt.plot(time[:,1],bmal_prtn[:,1],c='r',label="bmal1")
plt.plot(time[:,1],cry_prtn[:,1],c='g',label="cry")
plt.plot(time[:,1],nrld_prtn[:,1],c='b',label="nr1d1")
#plt.plot(avg_t,avg_bmal_p,label="avg bmal")
#plt.plot(avg_t,avg_cry_p,label="avg cry")
#plt.plot(avg_t,avg_nrld_p,label="avg nrld")
plt.title("Protein vs time")
plt.legend()
plt.figure()
plt.plot(time[:,1],bmal_mRNA[:,1],c='r',label="bmal1")
plt.plot(time[:,1],cry_mRNA[:,1],c='g',label="cry")
plt.plot(time[:,1],nrld_mRNA[:,1],c='b',label="nr1d1")
#plt.plot(avg_t,avg_bmal_m,label="avg bmal")
#plt.plot(avg_t,avg_cry_m,label="avg cry")
#plt.plot(avg_t,avg_nrld_m,label="avg nrld")
plt.title("mRNA vs time")
plt.figure()


#store average concentrations
#avg_data={'time':avg_t, 'bmal_mRNA':avg_bmal_m, 'cry_mRNA':avg_cry_m,'nrld_mRNA':avg_nrld_m, 'bmal_prtn':avg_bmal_p, 'cry_prtn':avg_cry_p, 'nrld_prtn':avg_nrld_p}
#header=['time', 'bmal_mRNA', 'cry_mRNA', 'nrld_mRNA', 'bmal_prtn', 'cry_prtn', 'nrld_prtn']
#df = pd.DataFrame(avg_data, columns=header)
#df.to_csv('for_ft.csv')

#store data at a single time point
#data={'time':time[30000,:],'bmal_mRNA':bmal_mRNA[30000,:],'cry_mRNA':cry_mRNA[30000,:], 'nrld_mRNA':nrld_mRNA[30000,:]}
#header1=['time', 'bmal_mRNA', 'cry_mRNA', 'nrld_mRNA','bmal_prtn','cry_prtn','nrld_prtn']
#dataf=pd.DataFrame(data,columns=header1)
#dataf.to_csv('at17h_100.csv')

#data1={'time':time[44117,:],'bmal_mRNA':bmal_mRNA[44117,:],'cry_mRNA':cry_mRNA[44117,:], 'nrld_mRNA':nrld_mRNA[44117,:]}
#dataf1=pd.DataFrame(data1,columns=header1)
#dataf1.to_csv('at25h_100.csv')

#data2={'time':time[65294,:],'bmal_mRNA':bmal_mRNA[65294,:],'cry_mRNA':cry_mRNA[65294,:], 'nrld_mRNA':nrld_mRNA[65294,:]}
#dataf2=pd.DataFrame(data2,columns=header1)
#dataf2.to_csv('at37h_100.csv')

#timeSer={'time':time[0:299999:1000,1],'bmal_mRNA':bmal_mRNA[0:299999:1000,1],'cry_mRNA':cry_mRNA[0:299999:1000,1], 'nrld_mRNA':nrld_mRNA[0:299999:1000,1], 'bmal_prtn':bmal_prtn[0:299999:1000,1],'cry_prtn':cry_prtn[0:299999:1000,1],'nrld_prtn':nrld_prtn[0:299999:1000,1]}
#timeSer_f=pd.DataFrame(timeSer, columns=header1)
#timeSer_f.to_csv('timeSer3.csv')

  
multiSer_bmal_f=pd.DataFrame(bmal_prtn[100000:(iter_t-1):1000,:],columns=['Column_' + str(i + 1) for i in range(repeat)])
multiSer_bmal_f.to_csv('multiSer_bmalp2.csv')


# In[40]:


#parameters obtained by fitting smFISH data
#[A0,A1,A2,phi_1,phi_2]
#bmal1=[61.34214647  7.96927134 -4.48858411 -1.89047226  0.6577511 ] 
#cry1=[22.47499178  1.60274174 -1.82175564  2.32538813  0.53898115] 
#nr1d1=[55.02797929 -5.97974468  9.12376118 -4.03139263 -5.92900805]


#new set of parameters 
[57.70638766  5.35063807 -2.17035104 -1.6429104   1.16164802] 
[21.71373706  1.7780006  -0.42707404  1.18330433 -6.49202669] 
[48.81575631   6.75209331   2.85215429 -13.03485347   0.797486]


# In[17]:


#find the rate of the homogeneouns Poisson process
import numpy as np
import matplotlib.pyplot as plt
from random import random
from math import log, cos, pi
import pandas as pd

s=np.linspace(0,72,100)
delta= log(2)/2
A0=[57.71,21.71,48.81]
A1=[5.35,1.78,6.75]
A2=[-2.17,-0.43,2.85]
phi_1=[-1.64,1.18,-13.03]
phi_2=[1.16,-6.49,0.8]
#burst frequency scale=1/mRNA half-life
#gamma=[0.109,0.254,0.0682]
gamma=[0.142,0.306,0.0723]

#the mRNA concentrations according to the cosinor model
def promoter1(gama,A0,A1,A2,phi_1,phi_2,t):
    delta= log(2)/2                  
    w=2*pi/24.
    return delta*gama*(A0/2. + A1*np.cos(w*t-phi_1) + A2*np.cos(2*w*t-phi_2))

b=promoter1(gamma[0],A0[0],A1[0],A2[0],phi_1[0],phi_2[0],s)
c=promoter1(gamma[1],A0[1],A1[1],A2[1],phi_1[1],phi_2[1],s)
n=promoter1(gamma[2],A0[2],A1[2],A2[2],phi_1[2],phi_2[2],s)

print(np.amax(b),np.amax(c),np.amax(n))
plt.plot(s,b,c='r', label="bmal1")
plt.plot(s,c,c='g',label="cry")
plt.plot(s,n,c='b',label="nr1d1")
plt.legend()

#data={'time':s,'bmal_kon':b,'cry_kon':c, 'nrld_kon':n}
#header1=['time', 'bmal_kon', 'cry_kon', 'nrld_kon']
#dataf=pd.DataFrame(data,columns=header1)
#dataf.to_csv('cosinor_fit.csv')


# In[16]:


1630*33


# In[ ]:




