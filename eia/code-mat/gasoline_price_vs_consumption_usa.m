cca

%%
series1='PET.EMM_EPM0_PTE_NUS_DPG.W';
series2='PET.MGFUPUS2.M';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

[dinit2,metadata]=load_eia_series(series2);
d2=process_monthly_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%
[dates,infl]=inflation_vs_t(d1.dates);

petro_infl=d1.y./infl;

%%

fig=gcf;
fig.Position=[125 385 1007 550];

petro_infl=moving_average(dates,petro_infl,30*3);

petro_infl(end-15:end)=d1.y(end-15:end)./infl(end-15:end);
p=plot(dates,petro_infl,'linewidth',3,'color',leftycolor);
p.Color(4)=0.5;

%%
grid on
xlim([d1.dates(100) d1.dates(end)+calmonths(12)])

ax=gca;
ax.FontSize=22;
y_lim=[1.5 6];
ylim(y_lim);
yticks=[1:6];
ax.YTick=yticks;

yticklbl={};

for i=1:numel(yticks)
    yticklbl{i}=sprintf('$%.2f',yticks(i));
end

ax.YTickLabel=yticklbl;

lylbl=ylabel('Gasoline Price [2022 USD]');
lylbl.Position=[-300 3.7500 -1.0000];

yyaxis right

gasoline=moving_average(d2.dates,d2.y,30*3);

p=plot(d2.dates,gasoline/1000,'linewidth',3,'color',rightycolor);
p.Color(4)=0.5;

ylim([7.5 10])
ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

rylbl=ylabel('Finished Motor Gasoline [mbpd]');
%rylbl.Position=[1.3131e+04 5.5000e+03 -1.0000];

%ax.Position=[0.1271 0.1200 0.7779 0.7340];
tt=title(sprintf('U.S. Gasoline Demand Destruction'),'fontsize',30);

lgn=legend('Gasoline Prices','Gasoline Consumption','fontsize',25);
lgn.Position=[0.1331 0.8009 0.2944 0.1155];

text(0.55,-0.11,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',17,'FontName','Times','units','normalized')

%%
print('~/projects/eia/post/gasoline_price_vs_consumption_usa','-dpng')
