cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%%

lp=log(price/price(1));


%% Plot least squares
dls = [];
for i=1:numel(dates)
    dls(i)=days(dates(i)-dates(1));
end

[yo,mo,x,bo]=least_squares(dls,lp);

%% Extrapolate a bit

ppx=[x;[x(end):(x(end)+365*5)]'];
pp=polyfit(x,yo,1);
ppy=polyval(pp,ppx);

ppx(1:numel(x))=[];
ppy(1:numel(x))=[];

%%

trendcolor=[207 181 59]/256;

plot(dates,price,'b','linewidth',2)

hold on
plot(dates(1)+x,exp(yo)*price(1),'linewidth',4,'color',trendcolor)
plot(dates(1)+ppx,exp(ppy)*price(1),'linewidth',4,'linestyle','--','color',trendcolor)
hold off


%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on
%ylabel('')

lgn=legend('S&P 500','70 Year Least Squares Fit','Extrapolation');
lgn.Position=[0.6993 0.1985 0.1520 0.1240];


ylbl=ylabel('S&P 500 Price');
ylbl.Position(1)=1.3806e+04;


ax=gca;
ax.FontSize=18;



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

fig=gcf;
fig.Position=[23 367 1500 500];

xlim([datetime(1990,1,1) datetime(2029,1,1)])

text(0.67,-0.1,sprintf('Twitter: @peterdevietien   Last date: %s',datestr(dates(end),'dd-mmm-yyyy')),'fontsize',17,'units','normalized')

title('S&P 500 and 70 Year Least Squares Fit','fontsize',30)

%%
print('~/projects/stock/post/sp500_least_squares_linear','-dpng')