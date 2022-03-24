function [dates,marketcap]=edgar_yf_marketcap(cik,ticker)

[time,shares]=edgar_shares(cik);

%%

d=load_ticker_data(ticker);

%%
marketcap=nan(numel(d.dates),1);
dates=d.dates;

for i=1:numel(time)
    sel=d.dates<=time(i);
    marketcap(sel)=d.close(sel)*shares(i);
end