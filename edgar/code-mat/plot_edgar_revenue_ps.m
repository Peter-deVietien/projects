cca

ciktable=readtable('~/projects/edgar/data/ticker_cik.csv');

cik='0001318605';
[tstart,tend,revenue]=edgar_revenue(cik);

%%
b=bar(tstart+days(45),revenue/1e9);
b.FaceAlpha=0.3;

ylabel('Quarterly Revenue [$bn]')

yyaxis right


%%
ticker='TSLA';
d=load_ticker_data(ticker);

[dates,marketcap]=edgar_yf_marketcap(cik,ticker);

%%

nt=numel(tend);
psrat=nan(numel(marketcap),1);

for i=1:nt
    sel=(dates>=tstart(i)) & (dates<=tend(i));
    psrat(sel)=marketcap(sel)/(revenue(i)*4);
end

sel=dates>=tend(i);
psrat(sel)=marketcap(sel)/(revenue(end)*4);

psrat=moving_average(dates,psrat,30);

plot(dates,psrat,'linewidth',4)

ylabel('Forward Price to Sales Ratio')

xlim([datetime(2018,1,1) datetime()+calmonths(3)])


%%
ax=gca;
ax.FontSize=18;
ax.XTickLabelRotation=90;

grid on

fig=gcf;
fig.Position=[184 271 852 595];

lgn=legend('Quarterly Revenue [$bn]','Forward PS Ratio','fontsize',22);
lgn.Position=[0.2009 0.7076 0.3269 0.0950];

title_str=sprintf('Tesla Quarterly Revenue\n and Price to Sales');
title(title_str,'fontsize',30);

text(datetime(2014,6,1),-6,'@peterdevietien   Data: SEC EDGAR, Yahoo Finance','fontsize',18);

%%
filename='edgar_revenue_ps_TSLA';
print(sprintf('~/projects/edgar/post/%s',filename),'-dpng')