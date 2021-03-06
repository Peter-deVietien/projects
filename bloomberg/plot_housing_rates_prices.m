cca

[dates,rates]=load_mortgage_rates_30yr;
[pdates,prices]=load_us_housing_price_fhfa;

%%

p=plot(dates,rates,'linewidth',3);
p.Color(4)=0.6;

ax=gca;
ax.YTick=[0:2.5:20];

ylbl=[];
for i=1:numel(ax.YTick)
    ylbl=[ylbl {sprintf('%.1f%%',ax.YTick(i))}];
end
ax.YTickLabel=ylbl;

ylabel('30 Yr Mortgage Rates')

yyaxis right

[~,infl]=inflation_vs_t(pdates);

p=plot(pdates,prices./infl,'linewidth',3);
p.Color(4)=0.6;

ylabel('U.S. Housing Prices 2022 USD')

hold on
plot([datetime(2007,1,1) datetime(2007,1,1)],[0 1]*800,'k--')
plot([datetime(2012,6,1) datetime(2012,6,1)],[0 1]*800,'k--')
hold off

ylim([300 600])

%%
grid on
ax=gca;
ax.FontSize=15;
ax.XGrid='off';
ax.Position=[0.1300 0.1382 0.7750 0.7412];

lgn=legend('30yr Rates','Housing Prices');
lgn.Position=[0.4148 0.7589 0.2123 0.1200];

fig=gcf;
fig.Position=[237 255.4000 811 506.6000];

xl=xlim;
xlim([xl(1) xl(2)+calmonths(12)])

title(['Housing Prices and Mortgage Rates',newline,'Inflation Adjusted'])

txt=text(0.52,-0.126,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',12,'units','normalized');



%%
print('post/housing_rates_prices','-dpng')