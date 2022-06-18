cca

%%
series1='ELEC.PRICE.CA-ALL.Q';
series2='ELEC.PRICE.US-ALL.Q';
%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_quarterly_data(dinit1);

[dinit2,metadata]=load_eia_series(series2);
d2=process_quarterly_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ind=4*5;
d2.y=d2.y./d2.y(ind)*d1.y(ind);

d1.dates=d1.dates+calmonths(3);
d2.dates=d2.dates+calmonths(3);

%%
plot(d1.dates,d1.y,'linewidth',3,'color',leftycolor)

hold on
plot(d2.dates,d2.y,'linewidth',3,'color',rightycolor)
hold off

grid on

ax=gca;
ax.FontSize=14;
ax.XGrid='off';
ax.Position=[0.1300 0.1244 0.7750 0.7349];


ylabel('Cents per kWh')

tt=title(sprintf('California up 11%% YoY\nU.S. Average up 5.5%%'),'fontsize',18);


t1=text(0.5791,0.7461,sprintf('California Electricity\nPrice'),'fontsize',18,'units','normalized','color',leftycolor,'horizontalalignment','center','fontweight','light');
t2=text(0.4976,0.2261,'U.S. Average','fontsize',18,'units','normalized','color',rightycolor,'fontweight','light');
t3=text(0.6182,-0.1223,'Twitter: @peterdevietien   Data: EIA','fontsize',12,'FontName','Times','units','normalized');

%%

xlim([d2.dates(ind) d2.dates(end)+calmonths(12)])


%%
print('~/projects/eia/post/electricity_price_california','-dpng')
