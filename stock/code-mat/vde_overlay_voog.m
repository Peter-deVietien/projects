cca;
ticker1='IEF';
ticker=ticker1;
plot_price

t1.dates=dates_full;
t1.price=price;

ticker2='CL=F';
ticker=ticker2;
plt_color=[1 0 0];
overlay_price

t2.dates=dates_full;
t2.price=price;

hold on
plot([t2.dates(1) t2.dates(end)],[1 1]*t2.price(end),'k--')
hold off


%%
grid on
%ylim([0 330])

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('$%s and $%s',ticker1,ticker2);
title(title_str)

%xlim([datetime(2006,11,22) datetime(2021,07,16)])

lgn.String{3}=sprintf('Today''s $%s Price',ticker2);
lgn.Location='best';
lgn.Interpreter='none';

txt=text(datetime(2011,1,1),t2.price(end)*.85,sprintf('Today''s %s price: $%.2f\n@pdevietien',ticker2,t2.price(end)));
txt.FontSize=18;
txt.HorizontalAlignment='center';

pngname=sprintf('~/projects/stock/post/%s_overlay_%s',ticker1,ticker2);
print(pngname,'-dpng')
%%

t1i=interp1(t1.dates,t1.price,t2.dates);
ratio=t1i./t2.price;

k=find(~isnan(ratio),1,'last');

ratioma1=moving_average(t2.dates,ratio,365*1);
ratioma4=moving_average(t2.dates,ratio,365*4);

figure
plot(t2.dates,ratio)

hold on
plot(t2.dates,ratioma1,'linewidth',5)
plot(t2.dates,ratioma4,'linewidth',5)
plot([t2.dates(1) t2.dates(end)],[1 1]*ratio(k),'k--')
hold off

%ylim([0.6 4])
grid on
lgn=legend(sprintf('Ratio: $%s to $%s',ticker1,ticker2),'One New MA','Four Year MA','Today''s Ratio')
lgn.Location='best';
lgn.Interpreter='none';

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('Ratio of $%s to $%s\nBolded: One and Four Year Moving Average',ticker1,ticker2);
title(title_str,'interpreter','none')

x_lim=xlim;
x_lim(1)=max(t2.dates(1),t1.dates(1))-days(60);
x_lim(2)=x_lim(2)+days(60);
xlim(x_lim)

%xlim([datetime(2006,11,22) datetime(2021,07,16)])

txt=text(datetime(2013,1,1),ratio(k)*.8,sprintf('Today''s Ratio: %.2f\n@pdevietien',ratio(k)));
txt.FontSize=18;
txt.HorizontalAlignment='center';

pngname=sprintf('~/projects/stock/post/%s_overlay_%s_ratio',ticker1,ticker2);
print(pngname,'-dpng')