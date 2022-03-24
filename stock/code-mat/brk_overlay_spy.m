cca;
ticker='BRK-B';
plot_price

brk.dates=dates_full;
brk.price=price;

ticker='SPY';
plt_color=[1 0 0];
overlay_price

spy.dates=dates_full;
spy.price=price;

hold on
plot([spy.dates(1) spy.dates(end)],[1 1]*spy.price(end),'k--')
hold off

txt=text(datetime(2011,1,1),spy.price(end)-20,'Today''s SPY price');
txt.FontSize=18;

txt=text(datetime(2011,4,1),spy.price(end)-40,'@peterdevietien');
txt.FontSize=15;

%%
grid on
%ylim([0 330])

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('$BRK-B and $SPY');
title(title_str)

xlim([datetime(1995,1,1) datetime(2023,1,1)])

lgn.String{3}='Today''s $SPY Price';
lgn.Position=[0.5586 0.6470 0.1425 0.1165];

print('post/brk_overlay_spy','-dpng')
%%

brki=interp1(brk.dates,brk.price,spy.dates);
ratio=brki./spy.price;

ratioma1=moving_average(spy.dates,ratio,365*1);
ratioma6=moving_average(spy.dates,ratio,365*6);

figure
plot(spy.dates,ratio)

hold on
plot(spy.dates,ratioma1,'linewidth',5)
plot(spy.dates,ratioma6,'linewidth',5)
plot([spy.dates(1) spy.dates(end)],[ratio(end) ratio(end)],'k--')
hold off

%ylim([0.6 4])
grid on
legend('Ratio: $BRK to $SPY','One Year MA','Six Year MA','Today''s Ratio')

ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[53 239 1305 558];

title_str=sprintf('$BRK-B divided by $SPY\nBolded One and Six Year Moving Averages');
title(title_str)

xlim([datetime(1995,1,1) datetime(2023,1,1)])

txt=text(datetime(2013,1,1),ratio(end)-.05,sprintf('Today''s Ratio: %.2f',ratio(end)));
txt.FontSize=18;

txt=text(datetime(2013,1,1),ratio(end)-.1,'@peterdevietien');
txt.FontSize=15;

print('post/brk_overlay_spy_ratio','-dpng')