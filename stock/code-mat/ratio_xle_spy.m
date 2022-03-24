clear
close all

ticker1='XLE';
ticker=ticker1;
d=load_ticker_data(ticker);

t1.dates=d.dates_full;
t1.price=d.price;

ticker2='SPY';
ticker=ticker2;
d=load_ticker_data(ticker);

t2.dates=d.dates_full;
t2.price=d.price;

%%

t1i=interp1(t1.dates,t1.price,t2.dates);
ratio=t1i./t2.price;

k=find(~isnan(ratio),1,'last');

figure
plot(t2.dates,ratio,'linewidth',3)

hold on
plot([t2.dates(1) t2.dates(end)],[1 1]*ratio(k),'k--')
hold off

%ylim([0.6 4])
grid on
lgn=legend(sprintf('Ratio: $XLE/$SPY',ticker1,ticker2),'Today''s Ratio');
lgn.Position=[0.4924 0.7131 0.2475 0.1900];
lgn.Interpreter='none';


%ylim([0 30])

x_lim=xlim;
xlim([x_lim(1) x_lim(2)+days(60)])

%%

txt=text(datetime(1999,6,1),ratio(k)+1.2,sprintf('@peterdevietien                            %sth, %s: %.2f',datestr(now,'mmmm dd'),datestr(now,'yyyy'),ratio(k)));
txt.FontSize=18;
%txt.HorizontalAlignment='center';

%%
ax=gca;
ax.FontSize=22;
yyaxis right
copyAxis(ax.YAxis(1), ax.YAxis(2))

fig=gcf;
fig.Position=[53 239 1200*2/3 675*2/3];

pngname=sprintf('~/projects/stock/post/ratio-%s-%s',ticker1,ticker2);
print(pngname,'-dpng')