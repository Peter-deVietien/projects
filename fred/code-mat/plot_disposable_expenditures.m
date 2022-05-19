cca

series_key='MEPAINUSA672N';
[idates,pers_income]=load_fred_series(series_key);

series_key='A794RX0Q048SBEA';
[cdates,pers_consum]=load_fred_series(series_key);

%%

idates(end+1)=datetime(2021,1,1);
idates(end+1)=datetime(2022,1,1);
idates(end+1)=datetime(2023,1,1);

pers_income(end+1)=pers_income(end);
pers_income(end+1)=pers_income(end);
pers_income(end+1)=pers_income(end);

[sdates,s_consum,s_income]=colocate(cdates,pers_consum,idates,pers_income);

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(sdates,(s_income-s_consum),'linewidth',2)

%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';

ylabel('Income - Expenditures [thousands USD]')

title('Real Median Income less Real Expenditures')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(3)])

%ylim([18 25])

t1=text(0.18,0.08,'Real Personal Consumption Expenditures (PCEC96)','fontsize',12,'units','normalized');
t2=text(0.18,0.025,'Real Median Personal Income in the United States (MEPAINUSA672N)','fontsize',12,'units','normalized');