import sys
import yfinance as yf
import pandas as pd

#print(sys.argv[1])

homedir='/Users/peter/projects/stock/data'
#homedir='C:/Users/pdevi/Desktop/projects/stock/data'
stock_ticker=sys.argv[1]
#stock_ticker='BTC-USD'

stock_obj=yf.Ticker(stock_ticker)

hist=stock_obj.history(period="max")

data=pd.DataFrame(hist)

data.rename(columns={'Stock Splits':'Stock_Splits'},inplace=True)
print(data.columns)

data.to_csv(homedir+'/'+stock_ticker+'_historical_prices.csv')
