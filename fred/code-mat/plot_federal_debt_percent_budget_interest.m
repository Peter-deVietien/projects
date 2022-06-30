cca

series_key='A091RC1Q027SBEA';
[dates,interest_expense]=load_fred_series(series_key);

series_key='MTSR133FMS';
[rdates,mrevenue]=load_fred_series(series_key);

rdates=rdates(1:end-4);
mrevenue=mrevenue(1:end-4);

revenue=movsum(mrevenue,[11 0])/1000;

[s_dates,s_interest]=dspline(dates,interest_expense,rdates);

perc_interest=s_interest./revenue*100;

perc_interest=perc_interest(20:end);
s_dates=s_dates(20:end);

[idates,interest]=load_federal_debt_interest_rate;

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

plot(idates,interest,'linewidth',3,'color',leftycolor)

ylabel('Average Interest Rate')

ax=gca;
ax.FontSize=15;
ylim([0 7])
yticks=ax.YTick;
ylbl=[];

for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.1f%%',yticks(i))}];
end

ax.YTickLabel=ylbl;

yyaxis right

plot(s_dates,perc_interest,'linewidth',3,'color',rightycolor)

ylabel('Percent of Federal Tax Revenue')

ylim([0 50])

ax=gca;
ax.FontSize=15;
yticks=ax.YTick;

ylbl=[];

for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.1f%%',yticks(i))}];
end

ax.YTickLabel=ylbl;

%%
grid on

ax=gca;
ax.XGrid='off';
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;


title(['If interest rates went back to 6%, then 50% of all',newline,'tax revenue would go to paying interest on federal debt'],'fontsize',15)

xl=xlim;
xlim([datetime(2000,1,1) xl(2)+calmonths(6)])

lgn=legend('Average Interest Rate on Federal Debt','Percent of Federal Budget Paying Debt Interest');

%t1=text(0.296,0.08,'Data Up to March 1st 2022','fontsize',11,'units','normalized');
%t2=text(0.296,0.025,'Personal Consumption Expenditures: Energy Goods and Services','fontsize',11,'units','normalized');
t3=text(0.527,-0.111,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',11,'units','normalized');

%%
filename='federal_debt_percent_budget_interest';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')