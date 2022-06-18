cca

series_key='GFDEBTN';
[dates,balance]=load_fred_series(series_key);

%%
[dates,infl]=inflation_vs_t(dates);

balance=balance/1e6;

infl_balance=balance./infl;

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(dates,balance,'linewidth',2)
hold on
plot(dates,infl_balance,'linewidth',2)
hold off

ylabel('Trillions USD')

%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';

title('U.S. Federal Debt')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(12)])


%t1=text(0.296,0.08,'Data Up to March 1st 2022','fontsize',11,'units','normalized');
%t2=text(0.296,0.025,'Personal Consumption Expenditures: Energy Goods and Services','fontsize',11,'units','normalized');
t3=text(0.527,-0.111,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',11,'units','normalized');

%%
filename='federal_debt';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')