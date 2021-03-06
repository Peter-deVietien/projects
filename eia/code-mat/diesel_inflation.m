cca

%%
series1='PET.EMD_EPD2D_PTE_NUS_DPG.W';

%%
[dinit1,metadata]=load_eia_series(series1,true);
d1=process_weekly_data(dinit1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
brent_color=[0.4660 0.6740 0.1880];
%%
[pdates,infl]=inflation_vs_t(d1.dates);

petro_infl=d1.y./infl;

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p=plot(pdates,petro_infl,'linewidth',2,'color',leftycolor);
p.Color(4)=0.8;

hold on
p=plot([pdates(1) pdates(end)],[1 1]*petro_infl(end),'linewidth',1,'color',leftycolor);
p.Color(4)=0.3;
hold off

%%
grid on
xlim([d1.dates(100) d1.dates(end)+calmonths(12)])

ax=gca;
ax.FontSize=15;
y_lim=[1.2 7];
ylim(y_lim);
yticks=[0:8];
ax.YTick=yticks;

yticklbl={};

for i=1:numel(yticks)
    yticklbl{i}=sprintf('$%.2f',yticks(i));
end

ax.YTickLabel=yticklbl;

lylbl=ylabel('Diesel Price [$]');


tt=title(sprintf('U.S. Diesel Prices \nInflation Adjusted [2022 USD]'),'fontsize',18);

t2=text(0.5248,0.0388,['All Items US CPI, Last Date ',datestr(d1.dates(end))],'fontsize',13,'FontName','Times','units','normalized');
t3=text(0.4683,-0.1124,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',12,'FontName','Times','units','normalized');

%%
print('~/projects/eia/post/diesel_inflation','-dpng')
