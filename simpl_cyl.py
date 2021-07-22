#circadian clock without noise
#simple model by Kim&Forger 

import numpy as np
import matplotlib.pyplot as plt
from math import sqrt

delt=0.001
t=np.arange(0,120,delt)
At=0.05
Kd=10**(-4)
beta=0.15
m=np.zeros(len(t))
pc=np.zeros(len(t))
pn=np.zeros(len(t))
Af=np.zeros(len(t))
m[0]=.05
pc[0]=.07
pn[0]=.02

for i in range(len(t)-1):
    Af[i]=.5*((At-pn[i]-Kd)+sqrt((At-pn[i]-Kd)**2)+4*At*Kd)
    m[i+1]=m[i]+delt*beta*(Af[i]/At- m[i])
    pc[i+1]=pc[i]+delt*beta*(m[i]-pc[i])
    pn[i+1]=pn[i]+delt*beta*(pc[i]-pn[i])
    
plt.plot(t,m,"g--")
plt.plot(t,pn, "r--")
plt.plot(t,pc, "b")
plt.xlim(24,98)
plt.ylim(0,0.14)
plt.show()
