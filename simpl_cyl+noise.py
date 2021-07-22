#circadian clock with noise
#implementation of CLE with Euler-Maruyama method

import numpy as np
import matplotlib.pyplot as plt
from math import sqrt

delt=0.001
t=np.arange(0,75,delt)
At=0.05             #total concentration of BMAL-CLOCK complex
Kd=10**(-4)         #dissociation constant
beta=0.15           
q=0.007              #noise strength
m=np.zeros(len(t))  #PER mRNA
pc=np.zeros(len(t)) #PER protein in cytoplasm
pn=np.zeros(len(t)) #PER protein in nucleus
Af=np.zeros(len(t)) #fraction of free/unbound BMAL-CLOCK complex
m[0]=.05
pc[0]=.07
pn[0]=.04

for i in range(len(t)-1):
    Af[i]=.5*((At-pn[i]-Kd)+sqrt((At-pn[i]-Kd)**2 + 4*At*Kd))
    dw=np.random.normal(loc=0.0, scale=sqrt(delt), size=(6,1))
    m[i+1]=m[i]+delt*beta*(Af[i]/At - m[i])+q*((sqrt(Af[i]/At)*dw[0])+(sqrt(m[i])*dw[1]))
    pc[i+1]=pc[i]+delt*beta*(m[i]-pc[i])+q*((sqrt(m[i])*dw[2])+(sqrt(pc[i])*dw[3]))
    pn[i+1]=pn[i]+delt*beta*(pc[i]-pn[i])+q*((sqrt(pc[i])*dw[4])+(sqrt(pn[i])*dw[5]))
    
plt.plot(t,m,"g--", label="PER mRNA")
plt.plot(t,pn, "r--", label="PER protein")
plt.plot(t,pc, "b", linewidth=0.5, label="PER in cytoplasm")
#plt.axhline(y=0.088)
plt.legend()
plt.show()
