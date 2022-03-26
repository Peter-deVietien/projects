if ~exist('plot_logistics','var')
    plot_logistics=1;
end

if plot_logistics
    clearvars -except plot_logistics
    close all
end


L=100*1000;
x0=120;
k=.028;
x=[-60:300];
t0=datetime(2022,1,1);
t=t0+x;

if plot_logistics

%%
f=L./(1+exp(-k.*(x-x0)));

sumf=cumsum(f);

%%
dt=@(y,m,d)datetime(y,m,d);

ddates=[dt(2021,11,1),dt(2021,12,22),dt(2022,1,16),dt(2022,1,30),dt(2022,2,13), dt(2022,2,27), dt(2022,3,13), dt(2022,3,20), dt(2022,3,27)];
ddeliv=[     0,           65,             100,          100,        100,           149,            175,         175,            175]*1000;
sumdeliv=cumsum(ddeliv);


plot(ddates,sumdeliv)

hold on
plot(t,f/k)
hold off

xlim([ddates(1) ddates(end)+calmonths(1)])

%%
figure
h(1)=plot(t,f,'linewidth',4,'DisplayName','Curve Fit');

%%
grid on

ylabel('Daily Courses Delivered [thousands]')

%%
title(sprintf('U.S. Daily Paxlovid \nCourses Delivered'));
legend(h);

%%
fig=gcf;
fig.Position=[61 344 639 479];

ax=gca;
ax.FontSize=19;

%%
text(datetime(2022,6,10),3.5,'@peterdevietien','fontsize',18)

%%
print('~/projects/covid/post/paxlovid_daily_deliveries','-dpng')


%%
if 0
figure

plot(t,sumf/1000,'linewidth',5)

grid on

ylabel('Cumulative Deliveries [millions]')

title(sprintf('Cumulative sum of logistics function\n in daily deliveries graph'))

ax=gca;
ax.FontSize=15;

print('~/projects/covid/post/paxlovid_deliveries','-dpng')
end
end