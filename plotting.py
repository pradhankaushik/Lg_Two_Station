import matplotlib.pyplot as plt
from math import *
import numpy as np
freq = []
y_value = []

ff = open('f_y.txt','r')
lines = ff.readlines()

for i in lines:
	freq.append(i.split()[0])
	y_value.append(i.split()[1])

for i in range(len(y_value)):
	freq[i] = float(freq[i])
	y_value[i] = float(y_value[i])

log_freq = []
log_y_value = []
fff = open('log_f_log_y.txt','r')
lines2 = fff.readlines()
for i in lines2:
	log_freq.append(i.split()[0])
	log_y_value.append(i.split()[1])

for i in range(len(log_y_value)):
	log_freq[i] = float(log_freq[i])
	log_y_value[i] = float(log_y_value[i])

x = log_freq[:]
pred_x = []
for i in range(len(x)):
	f_x = x[i] * 0.0459254 - 4.34719 
	pred_x.append(f_x)

x2 = [] 
y2 = []
for i in range(len(x)):
	new_x = e**x[i]
	new_y = e**pred_x[i]
	x2.append(new_x)
	y2.append(new_y)

plt.yscale("log")
plt.xscale("log")	
plt.scatter(freq,y_value)
plt.plot(x2,y2,'r')
plt.xlabel('Frequency (Hz)')
#plt.set_xlim([0,10000]) 
plt.title('SUND and RMTK Log Log Scale')
plt.ylabel('Y Value')
#plt.yticks(np.arange(10**-6, 10**-5, 10**-1)) 
#plt.axhline(y=1.0, color='r', linestyle='-',linewidth=2)
#plt.axhline(y=2.0, color='green', linestyle='-',linewidth=2)
#plt.legend(loc="upper right")
#axes = plt.gca()
#axes.set_xlim([0,7000])
#axes.set_ylim([0,10])
plt.show()
