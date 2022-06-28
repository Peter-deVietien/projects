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
%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(dates,petro_infl,'linewidth',2,'color',leftycolor)

hold on
p=plot([dates(1) dates(end)],[1 1]*petro_infl(end),'linewidth',1,'color',leftycolor);
p.Color(4)=0.3;
hold off

grid on

ax=gca;
ax.FontSize=16;
y_lim=[1.5 6];
ylim(y_lim);
yticks=[1:6];
ax.YTick=yticks;

yticklbl={};

for i=1:numel(yticks)
    yticklbl{i}=sprintf('$%.2f',yticks(i));
end

ax.YTickLabel=yticklbl;

yyaxis right

ax=gca;
ax.YAxis(2).Color='k';
ylim(y_lim)
ax.YTick=yticks;
ax.YTickLabel=yticklbl;

ax.XTick=[datetime(2001-8,1,1):calyears(4):datetime(2025,1,1)];

ax.Position=[0.1271 0.1200 0.7779 0.7340];
tt=title(sprintf('U.S. Gasoline Prices \n Inflation Adjusted [2022 USD]'),'fontsize',18);


%%

xlim([d1.dates(1) d1.dates(end)+calmonths(12)])

if 1
   hold on
   %plot([datetime(2001,1,1) datetime(2001,1,1)],[0 80000],'m-','linewidth',2)
   plot([datetime(2009,1,1) datetime(2009,1,1)],[0 8],'g-','linewidth',2)
   plot([datetime(2017,1,1) datetime(2017,1,1)],[0 8],'g-','linewidth',2)
   plot([datetime(2021,1,1) datetime(2021,1,1)],[0 80000],'g-','linewidth',2)    
   plot([datetime(2025,1,1) datetime(2021,1,1)],[0 80000],'g-','linewidth',2)    
   hold off

   text(datetime(2003,1,1),5.7,'Bush','fontsize',20,'fontname','Times')
   text(datetime(2012,1,1),5.7,'Obama','fontsize',20,'fontname','Times')
   text(datetime(2018,1,1),5.7,'Trump','fontsize',20,'fontname','Times')
   text(datetime(2022,4,1),5.7,'Biden','fontsize',20,'fontname','Times')
   
   xlim([datetime(2009,1,1) datetime(2025,1,1)])
   
   t1=text(0.0082,0.0388,['All Items US CPI, Last Date ',datestr(d1.dates(end))],'fontsize',13,'FontName','Times','units','normalized');
   filename='gasoline_price_usa_presidents';
else
   t1=text(0.5248,0.0388,['All Items US CPI, Last Date ',datestr(d1.dates(end))],'fontsize',13,'FontName','Times','units','normalized');
    filename='gasoline_price_usa';

end




t2=text(0.4750,-0.1342,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',12,'FontName','Times','units','normalized');

%%
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')
