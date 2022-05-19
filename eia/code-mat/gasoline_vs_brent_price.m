cca

%%
series1='PET.EMM_EPMR_PTE_NUS_DPG.W';
series2='PET.RBRTE.D';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

[dinit2,metadata]=load_eia_series(series2);
d2=process_weekly_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
brent_color=[0.4660 0.6740 0.1880];
%%
[pdates,infl1]=inflation_vs_t(d1.dates);
[bdates,infl2]=inflation_vs_t(d2.dates);

petro_infl=d1.y./infl1;
brent_infl=d2.y./infl2;

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p=plot(pdates,petro_infl,'linewidth',1,'color',leftycolor);
p.Color(4)=0.8;


%%
grid on
xlim([d1.dates(100) d1.dates(end)+calmonths(12)])

ax=gca;
ax.FontSize=15;
y_lim=[1.2 6];
ylim(y_lim);
yticks=[0:6];
ax.YTick=yticks;

yticklbl={};

for i=1:numel(yticks)
    yticklbl{i}=sprintf('$%.2f',yticks(i));
end

ax.YTickLabel=yticklbl;

lylbl=ylabel('Gasoline Price [2022 USD]');


yyaxis right

p=plot(bdates,brent_infl,'linewidth',1,'color',rightycolor);
p.Color(4)=0.5;

ylim([0 200])
ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

rylbl=ylabel('Brent Price [2022 USD]');

%%
opacity=0.6;
%t1=text(0.41,0.2,sprintf('Crude Oil Price'),'fontsize',20,'color',rightycolor,'units','normalized','horizontalalignment','center');
%t2=text(0.52,0.88,'Gasoline Price','fontsize',20,'color',(1 - opacity * (1 - leftycolor)),'units','normalized');

%ax.Position=[0.1271 0.1200 0.7779 0.7340];
tt=title(sprintf('U.S. Crude and Gasoline Prices'),'fontsize',20);

lgn=legend('Gasoline Price','Brent Price','fontsize',17);
lgn.Position=[0.1375 0.7700 0.2658 0.1350];

t3=text(0.4683,-0.1124,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',12,'FontName','Times','units','normalized');

%%
print('~/projects/eia/post/gasoline_vs_crude_price_usa','-dpng')
