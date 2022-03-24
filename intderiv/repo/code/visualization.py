import sys
import yfinance as yf
import pandas as pd

%matplotlib widget
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
from datetime import datetime as dt
from datetime import date
from datetime import timedelta
#import pickle


stock_ticker='OIH'
stock_obj=yf.Ticker(stock_ticker)
history=stock_obj.history(period="max")

objexpirs=stock_obj.options
objexpirs=sorted(objexpirs)
