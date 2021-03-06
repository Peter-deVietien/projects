cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%%



%% Get Least Squares
lp=log(price/price(1));
dls=days(dates-dates(1));

[yo,mo,x,bo]=least_squares(dls,lp);

%% Extrapolate a bit

ppx=[x;[x(end):(x(end)+365*5)]'];
pp=polyfit(x,yo,1);
ppy=polyval(pp,ppx);

ppx(1:numel(x))=[];
ppy(1:numel(x))=[];

%%

trendcolor=[207 181 59]/256;

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p(1)=plot(dates,price,'b','linewidth',1);

hold on
plot([dates(1) dates(end)+calyears(20)],[1 1]*price(end),'b','linewidth',0.2)
p(2)=plot(dates(1)+x,exp(yo)*price(1),'linewidth',1,'color',trendcolor);
p(3)=plot(dates(1)+ppx,exp(ppy)*price(1),'linewidth',1,'linestyle','--','color',trendcolor*1.1);
hold off


%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on

lgn=legend(p,'S&P 500','70 Year Least Squares Fit','Extrapolation');
lgn.Position=[0.1408 0.6056 0.2942 0.1395];


ylbl=ylabel('S&P 500 Price');
%ylbl.Position(1)=1.3806e+04;


ax=gca;
ax.FontSize=13;



%%
ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;
y_lim=ylim;
yyaxis right
ax.YAxis(2).Color='k';
ax=gca;
ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;
ylim(y_lim);

%%



xlim([datetime(1948,1,1) datetime(2028,1,1)])

tt=title('S&P 500 and 70 Year Least Squares Fit','fontsize',20);

t1=text(0.47,-0.1073,sprintf('Twitter: @peterdevietien   Last date: %s',datestr(dates(end),'dd-mmm-yyyy')),'fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_least_squares_linear_zoomed_out','-dpng')