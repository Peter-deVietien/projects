cca

load_btc_data

%%
hrcolor='r';
gcolor=[0.9290 0.6940 0.1250];

%%

semilogy(dates,price)

%%
maxreturn=price(end)/price(1);

halfreturn=sqrt(maxreturn)*price(1);

ind=find(price>halfreturn,1,'first');

hold on
plot([dates(1) dates(end)],[1 1]*halfreturn,'linewidth',2,'color',hrcolor)
scatter(dates(ind),price(ind),500,'o','linewidth',3)

plot([dates(1) dates(end)],[1 1]*7*price(end),'color',gcolor,'linewidth',3)
hold off

%%
text(datetime(2013,1,1),3*price(end),'Total Market Cap of Physical Gold','fontsize',18,'color',gcolor)

da1=annotation('doublearrow',[.85 .85],[.5 .7]);
da1.Y=[0.49 0.77];

da2=annotation('doublearrow',[.85 .85],[.5 .7]);
da2.Y=[0.49 0.77]-.3;
da2.X=[0.17 0.17];

txt2=text(datetime(2015,1,1),halfreturn-20,'Line of Equal ROI','fontsize',18,'color',hrcolor);

txt3=text(datetime(2011,5,1),1,'920x return','fontsize',18);
txt4=text(datetime(2019,10,1),10^3,'920x return','fontsize',18);

%%

fig=gcf;
fig.Position=[1 93 711 765];

%%
ylabel('Bitcoin Price [USD]')

ax=gca;
ax.FontSize=18;
yticks=ax.YTick;
y_lim=ylim;

yyaxis right
ax=gca;
ax.YAxis(2).Scale='log';
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';

x_lim=xlim;
xlim([x_lim(1) x_lim(2)+calmonths(3)])

grid on


title(sprintf('Bitcoin: Half Lifetime ROI\nIncludes %s',datestr(dates(end),'dd mmm yyyy')))

%%
text(datetime(2020,1,1),3e-3,'@peterdevietien','fontsize',16)

%%
print('~/projects/stock/post/plot_btc_log','-dpng')