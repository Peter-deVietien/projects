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
ind=4*5;
d2.y=d2.y./d2.y(ind)*d1.y(ind);

d1.dates=d1.dates+calmonths(3);
d2.dates=d2.dates+calmonths(3);

%%
plot(d1.dates,d1.y,'linewidth',4,'color',leftycolor)

hold on
plot(d2.dates,d2.y,'linewidth',4,'color',rightycolor)
hold off

grid on

ax=gca;
ax.FontSize=22;
ax.XGrid='off';

fig=gcf;
fig.Position=[203 311 1174 555];

ylabel('Cents per kWh')

tt=title(sprintf('Price of Calfornia Electricity vs U.S. Average'),'fontsize',30);
%tt.Position=[3.1072e+03 9.110 1.4211e-14];

%lgn=legend('California','U.S. Average (normalized)');
%lgn.Position=[0.1508 0.8063 0.2304 0.0928];

t=text(0.62,0.83,sprintf('California Electricity\nPrice'),'fontsize',40,'units','normalized','color',leftycolor,'horizontalalignment','center');
t2=text(0.59,0.2,'U.S. Average','fontsize',40,'units','normalized','color',rightycolor);

%%

xlim([d2.dates(ind) d2.dates(end)+calmonths(12)])

text(0.7,-0.1,'Twitter: @peterdevietien   Data: EIA','fontsize',17,'FontName','Times','units','normalized')

%%
print('~/projects/eia/post/electricity_price_california','-dpng')
