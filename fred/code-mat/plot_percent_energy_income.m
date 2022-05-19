cca

series_key='MEPAINUSA672N';
[idates,pers_income]=load_fred_series(series_key);

series_key='DNRGRC1M027SBEA';
[cdates,pers_consum]=load_fred_series(series_key);

%%

idates(end+1)=datetime(2021,1,1);
idates(end+1)=datetime(2022,1,1);
idates(end+1)=datetime(2023,1,1);

pers_income(end+1)=pers_income(end);
pers_income(end+1)=pers_income(end);
pers_income(end+1)=pers_income(end);

[sdates,s_consum,s_income]=colocate(cdates,pers_consum,idates,pers_income);

[sdates,infl]=inflation_vs_t(sdates);

s_consum=s_consum./infl;

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(sdates,(s_consum./s_income*100),'linewidth',2)

%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';

ytick=ax.YTick;
ylbl=[];

for i=1:numel(ytick)
    ylbl=[ylbl {sprintf('%.1f%%',ytick(i))}];
end

ax.YTickLabel=ylbl;

%ylabel('Percent')

title('Percent of Median Income Towards Energy Consumption')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(3)])

%ylim([18 25])

t1=text(0.01,0.1345,'Data Up to March 1st 2022','fontsize',11,'units','normalized');
t2=text(0.01,0.08,'Personal Consumption Expenditures: Energy Goods and Services (DNRGRC1M027SBEA)','fontsize',11,'units','normalized');
t3=text(0.01,0.025,'Real Median Personal Income in the United States (MEPAINUSA672N)','fontsize',11,'units','normalized');
t4=text(0.527,-0.111,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',11,'units','normalized');

%%
filename='percent_energy_income';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')