clear
close all

ticker1='CL=F';
ticker=ticker1;
d=load_ticker_data(ticker);

t1.dates=d.dates_full;
t1.price=d.price;

ticker2='XAU=F';
ticker=ticker2;
d=load_ticker_data(ticker);

t2.dates=d.dates_full;
t2.price=d.price;

%%

t1i=interp1(t1.dates,t1.price,t2.dates);
ratio=t1i./t2.price;

k=find(~isnan(ratio),1,'last');

figure
plot(t2.dates,ratio,'linewidth',2)

hold on
plot([t2.dates(1) t2.dates(end)],[1 1]*ratio(k),'k--')
hold off

%ylim([0.6 4])
grid on
lgn=legend(sprintf('Ratio: $OIH/$QQQ',ticker1,ticker2),'Today''s Ratio');
%lgn.Position=[0.4924 0.7131 0.2475 0.1900];
lgn.Interpreter='none';


%ylim([0 40])

x_lim=xlim;
xlim([datetime(2001,1,1) x_lim(2)+days(60)])

%%

txt=text(0.8,-0.1,'Twitter: @peterdevietien','fontsize',16,'units','normalized');
txt.FontSize=18;

txt=text(datetime(2012,1,1),ratio(k)+1,sprintf('%sth, %s: %.2f',datestr(now,'mmmm dd'),datestr(now,'yyyy'),ratio(k)),'fontsize',16);

ttext=sprintf('Ratio of U.S. Oil Field Services ETF\n $OIH divided by NASDAQ 100 $QQQ');

text(0.7,0.7,ttext,'fontsize',30,'units','normalized','horizontalalignment','center')

%txt.HorizontalAlignment='center';

%%
ax=gca;
ax.FontSize=22;
yyaxis right
copyAxis(ax.YAxis(1), ax.YAxis(2))

fig=gcf;
fig.Position=[53 239 1257 538];

pngname=sprintf('~/projects/stock/post/ratio-%s-%s',ticker1,ticker2);
print(pngname,'-dpng')