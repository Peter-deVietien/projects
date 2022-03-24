import pandas as pd
import matplotlib.pyplot as plt

m=pd.read_csv('tsla_2013-2019.csv')
ts=pd.Series('tsla_2013-2019')

print(m['Date'])

plt.figure()

ts.plot()