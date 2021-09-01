#calculates fft and ifft of data imported from text files.

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from math import sin, cos

#insert input .csv file
#df=pd.read_csv('nfkb_noTNF.csv') 
#bmal1=df['nfkb']
#t=df['time']
t=np.arange(1,100)
a=np.sin(t/20.)
n=len(a)
f=np.fft.fft(a,n)
freq=np.fft.fftfreq(n)
freqp=freq[freq>=0]
psd=f * np.conj(f)/n
psd1=psd[0:len(freqp)]

#print(n)
#plt.figure()
#plt.plot(freq,psd)
#plt.yscale('log')
plt.plot(freqp[0:100],psd1[0:100], label='bmal mRNA')
plt.xlabel('frequency')
plt.ylabel('psd')
plt.legend()

y=np.max(psd1)
z=np.where(psd1==y)
print(freqp[z])
