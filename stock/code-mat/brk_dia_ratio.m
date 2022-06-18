cca;

brk=load_ticker_data('BRK-B');

dia=load_ticker_data('DIA');

%%

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%%

[~,euprice]=dspline(gdates,gprice,eu.dates_close);

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