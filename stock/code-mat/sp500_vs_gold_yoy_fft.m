cca

%%
ticker='^GSPC';
d=load_ticker_data(ticker);
dates=d.dates_close;
price=d.close;

[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

ratio=price./cprice;

%%
rat_yoy=nan(numel(dates),1);
dates_yoy=NaT(numel(dates),1);

if 0
for i=numel(dates):-1:360
    ind=find(dates>(dates(i)-calyears(1)),1,'first');
    rat_yoy(i)=ratio(i)/ratio(ind);
    dates_yoy(i)=dates(i);
end

sel=isnan(rat_yoy);

rat_yoy(sel)=[];
dates_yoy(sel)=[];

    save('gold_sp500_rat.mat','dates_yoy','rat_yoy')
else
    load('gold_sp500_rat.mat')
end

sel=isnan(rat_yoy);

rat_yoy(sel)=[];
dates_yoy(sel)=[];


Y=fft(rat_yoy);
L=numel(rat_yoy);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%plot([datetime(1800,1,1) datetime(2030,1,1)],[0 0],'k-','linewidth',0.5)

p(1)=plot(P1,'linewidth',1,'color',leftycolor);

%%
grid on
ax=gca;
ax.FontSize=15;

title(['FFT of YoY S&P 500 priced in ounces of gold'],'Fontsize',18)

ax.XGrid='off';


xlim([0 500])
ylim([0 0.01])

t1=text(0.0151,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.5266,-0.1088,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_vs_gold_yoy_fft','-dpng')