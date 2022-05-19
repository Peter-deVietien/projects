cca

series_key='DNRGRC1M027SBEA';
[ndates,nominal]=load_fred_series(series_key);

series_key='DNRGRX1M020SBEA';
[rdates,real]=load_fred_series(series_key);
%%
[ndates,infl]=inflation_vs_t(ndates);

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

p=plot(ndates,nominal,'linewidth',2,'color',leftycolor);
p.Color(4)=0.8;

ylabel('Billions Nominal USD')


yyaxis right

p=plot(rdates,real,'linewidth',2,'color',rightycolor);
p.Color(4)=0.6;

ylabel('Billions Real 2012 USD')
ylim([550 700])
%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

title('Real vs Nominal U.S. Energy Goods and Services')

xl=xlim;
xlim([datetime(2001,1,1) datetime(2023,1,1)])


lgn=legend('Nominal','Real');
lgn.Position=[0.3150 0.2471 0.1517 0.1083];

t1=text(0.238,0.12,'Data Up to March 1st 2022','fontsize',11,'units','normalized');
t2=text(0.238,0.0727,'Real Personal Consumption Expenditures: Energy Goods and Services','fontsize',11,'units','normalized');
t3=text(0.238,0.025,'Personal Consumption Expenditures: Energy Goods and Services','fontsize',11,'units','normalized');
t4=text(0.527,-0.111,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',11,'units','normalized');

%%
filename='consumption_real_nominal_energy';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')