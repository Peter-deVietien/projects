cca

cik='0000087347';
[tstart,tend,revenue]=edgar_revenue2(cik);

% %% Manully add
% tstart=[tstart datetime(2021,7,1) datetime(2021,10,1)];
% tend=[tend datetime(2021,9,30) datetime(2021,12,31)];
% revenue=[revenue 5.847e9 6.225e9];

%%
b=bar(tstart+days(45),revenue/1e9);
b.FaceAlpha=0.3;

ylabel('Quarterly Revenue [$bn]')

yyaxis right

%%
ticker='SLB';
d=load_ticker_data(ticker);

[dates,marketcap]=edgar_yf_marketcap(cik,ticker);

%%

nt=numel(tend);
psrat=nan(numel(marketcap),1);

for i=1:nt
    sel=(dates>=tstart(i)) & (dates<=tend(i));
    psrat(sel)=marketcap(sel)/(revenue(i)*4);
end

%% Fill in time since last report
sel=dates>=tend(i);
psrat(sel)=marketcap(sel)/(revenue(end)*4);

%% Fill in gaps



%%
psrat=moving_average(dates,psrat,30);

p=plot(dates,psrat,'linewidth',4);
p.Color(4)=0.7;

ylabel('Forward Price to Sales Ratio')
ylim([0 4])

%%
ax=gca;
ax.FontSize=18;
grid on

fig=gcf;
fig.Position=[184 271 852 595];

lgn=legend('Quarterly Revenue [$bn]','Forward PS Ratio','fontsize',22);
lgn.Position=[0.3477 0.2303 0.3269 0.0950];

title_str=sprintf('Schlumberger Quarterly Revenue\n and Price to Sales');
title(title_str,'fontsize',30);

text(datetime(2014,6,1),-6,'@peterdevietien   Data: SEC EDGAR, Yahoo Finance','fontsize',18);

%%
filename='edgar_revenue_ps_SLB';
print(sprintf('~/projects/edgar/post/%s',filename),'-dpng')