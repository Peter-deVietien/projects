cca

ticker='CL=F';

plot_price;
ma_days=365*3;
overlay_moving_average
load_ticker_data

grid on
f_dates=dates(end):1:datetime(2021,12,01);
f_price=linspace(price(end),42.84,numel(f_dates));

npl=numel(h);
hold on
h(npl+1)=plot(f_dates,f_price,'linewidth',3);
hold off
lgs=[lgs {sprintf('%s Futures',ticker)}];

fig=gcf;
fig.Position=[18 283 1376 515];

legend(h,lgs)

%%
hold on
plot([datetime(2008,11,01) datetime(2008,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2012,11,01) datetime(2012,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2016,11,01) datetime(2016,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2020,11,01) datetime(2020,11,01)],[-100 300],'k--','linewidth',3)
hold off

ylim([0 150])