cca

%%
series1='PET.EMM_EPMR_PTE_NUS_DPG.W';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%
[dates,infl]=inflation_vs_t(d1.dates);

petro_infl=d1.y./infl;

petro_infl=moving_average(dates,petro_infl,30*3);
petro_infl(end-15:end)=d1.y(end-15:end)./infl(end-15:end);

[wdates,wages]=median_wages_vs_t();

swages=dspline(wdates,wages,dates)/5;

gas_percent=petro_infl./swages*100*10;

%%

fig=gcf;
fig.Position=[125 385 1007 550];


p=plot(dates,gas_percent,'linewidth',3,'color',leftycolor);
p.Color(4)=0.7;

%%
grid on
xlim([d1.dates(100) d1.dates(end)+calmonths(12)])

ax=gca;
ax.FontSize=22;
y_lim=[5 30];
ylim(y_lim);
yticks=[5:5:30];
ax.YTick=yticks;

yticklbl={};

for i=1:numel(yticks)
    yticklbl{i}=sprintf('%.0d%%',yticks(i));
end

ax.YTickLabel=yticklbl;

lylbl=ylabel('Percent of Daily Wage');
lylbl.Position=[-200.7227 18.0000 -1];

yyaxis right


ax=gca;
ax.YTickLabel=yticklbl;
ax.YTick=yticks;

ylim(y_lim)

ax.YAxis(1).Color='k';
ax.YAxis(2).Color='k';

text(0.67,0.025,sprintf('Last Date Plotted: %s',datestr(dates(end),'dd mmm yyyy')),'fontsize',18,'units','normalized')

%ax.Position=[0.1271 0.1200 0.7779 0.7340];
tt=title(sprintf('Percent of Average U.S. Daily Wage \nfor Ten Gallons of Gasoline'),'fontsize',30);

text(0.55,-0.11,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',17,'FontName','Times','units','normalized')

%%
print('~/projects/eia/post/gas_percent_income','-dpng')
