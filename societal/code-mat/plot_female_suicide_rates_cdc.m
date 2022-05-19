cca

%%
load_female_suicide_rates_cdc

%%
plot(dates,suicide_10_14,'linewidth',3)

grid on

ax=gca;
ax.FontSize=18;
ylabel('Suicides per 100,000')
ylim([0 3])

fig=gcf;
fig.Position=[476 432 709 434];

title('Age 10-14 Female Suicide Rate in U.S.')

text(0.33,0.065,'CDC: Suicide Mortality in the United States, 1999–2019','fontsize',14,'units','normalized')
text(0.33,0.025,'https://www.cdc.gov/nchs/products/databriefs/db398.htm','fontsize',14,'units','normalized')

print('~/projects/societal/post/female_suicide_rates_cdc','-dpng')