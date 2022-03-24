cca

%%
series_key1='PET.MTTNT_NUS-NRS_2.M';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

%%
color1=[0 0.4470 0.7410];
color2=[0.8500 0.3250 0.0980];

%%
dates=d1.dates;
imports=d1.y;

%%
plot(dates,imports,'linewidth',2,'color',[color1 0.3])

ylabel(sprintf('Russian Imports [kbpd]'))

fig=gcf;
fig.Position=[159 409 877 457];

ax=gca;
ax.FontSize=19;

y_lim=[0 1000];
ylim(y_lim);
yticks=ax.YTick;

yyaxis right
ax=gca;
ax.YTick=yticks;
ylim(y_lim)
ax.YAxis(2).Color='k';


grid on

x_lim=xlim;

xlim([x_lim(1) x_lim(2)+calmonths(3)])

tt=title(sprintf('Russian Imports to USA of\nOil and Oil Products'),'fontsize',25);
%tt.Position=[3.7737e+03 110.6648 -0.5000];
tt.FontSize=25;
%tt.FontName='Arial Unicode MS';

%lgn=legend('Brent','Brent with Inflation','fontsize',18);
%lgn.Position=[0.2741 0.4715 0.1681 0.0873];

%%
text(datetime(2014,6,1),-120,'@peterdevietien  Data: EIA, St. Louis Fed','fontsize',16)

%%
print('~/projects/eia/post/net_imports_usa_russia','-dpng')
