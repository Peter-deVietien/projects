cca;
ticker='XOP';
plot_price

xop.dates=dates_full;
xop.price=price;

ticker='CL=F';
plt_color=[1 0 0];
overlay_price

clf.dates=dates_full;
clf.price=price;

hold on
plot([clf.dates(1) clf.dates(end)],[1 1]*clf.price(end),'k--')
hold off


%%
grid on
ylim([0 330])

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('$XOP and WTI');
title(title_str)

xlim([datetime(2006,11,22) datetime(2021,07,16)])

lgn.String{3}='Today''s WTI Price';

txt=text(datetime(2011,1,1),clf.price(end)-6.5,sprintf('Today''s WTI price: $%.2f',clf.price(end)));
txt.FontSize=18;

txt=text(datetime(2011,8,1),clf.price(end)-22,'@peterdevietien');
txt.FontSize=15;

print('~/projects/stock/post/xop_overlay_crude','-dpng')
%%

xopi=interp1(xop.dates,xop.price,clf.dates);
ratio=xopi./clf.price;

k=find(~isnan(ratio),1,'last');

ratioma1=moving_average(clf.dates,ratio,365*1);
ratioma4=moving_average(clf.dates,ratio,365*4);

figure
plot(clf.dates,ratio)

hold on
plot(clf.dates,ratioma1,'linewidth',5)
plot(clf.dates,ratioma4,'linewidth',5)
plot([clf.dates(1) clf.dates(end)],[1 1]*ratio(k),'k--')
hold off

ylim([0.6 4])
grid on
legend('Ratio: $XOP to CL=F','One New MA','Four Year MA','Today''s Ratio')

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('Ratio of $XOP to $WTI\nBolded Four Year Moving Average');
title(title_str)

xlim([datetime(2006,11,22) datetime(2021,07,16)])

txt=text(datetime(2013,1,1),ratio(k)-.1,sprintf('%sth: %.2f',datestr(now,'mmmm dd'),ratio(k)));
txt.FontSize=18;

txt=text(datetime(2013,2,1),ratio(k)-.26,'@peterdevietien');
txt.FontSize=15;

print('~/projects/stock/post/xop_overlay_crude_ratio','-dpng')