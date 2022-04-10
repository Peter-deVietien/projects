cca

load_dt_followers

%%
ndays1=5;
ndays2=2;

ind1=find(dates>(dates(end)-ndays1),1,'first');
ind2=find(dates>(dates(end)-ndays2),1,'first');

dates1=dates(ind1:end);
dates2=dates(ind2:end);

followers1=followers(ind1:end);
followers2=followers(ind2:end);

ndays1=days(dates1-dates1(1));
ndays2=days(dates2-dates2(1));

[yo1,mo1,x1,bo1]=least_squares(ndays1,followers1);
[yo2,mo2,x2,bo2]=least_squares(ndays2,followers2);

bardates1=dates1(1:end-numel(dates2));
barfollowers1=followers1(1:end-numel(dates2));

x=[-5:0.1:10];
y1=mo1*x+bo1;
lsdates1=dates1(1)+x;

y2=mo2*x+bo2;
lsdates2=dates2(1)+x;

b1=bar(bardates1,barfollowers1,'b');
b1.EdgeColor='b';
hold on
b2=bar(dates2,followers2,'g');
b2.BarWidth=min(b2.BarWidth,0.1);
b2.EdgeColor='g';
p(1)=plot(lsdates1,y1,'b','linewidth',3);
p(1).Color(4)=0.2;
p(2)=plot(lsdates2,y2,'g','linewidth',3);
p(2).Color(4)=0.2;
hold off

%%

%per_hour1=sprintf('%.0f,%3.0f',mo/24,mod(mo*1000/24,1000));
per_hour1=num2cstr(round(mo1*1000/24,0));
per_hour2=num2cstr(round(mo2*1000/24,0));


%%
grid on
ax=gca;
ax.FontSize=20;
ax.XAxis.TickLabelFormat='MMM dd';




ylabel('Trump Followers [thousands]')

title('Number of Followers Trump has on Truth Social')

fig=gcf;
fig.Position=[476 330 709 536];

yl=ylim;
ylim([580 850]+120)

xlim([dates1(1)-days(1) dates1(end)+days(3)])

lgn=legend(p,sprintf('New Followers Per Hour, Past 5 Days: %s',per_hour1),sprintf('New Followers Per Hour, Past Day: %s',per_hour2));
lgn.Position=[0.1291 0.8197 0.5416 0.1051];
text(0.33,0.82,sprintf('40,000/hr needed for 1m/day'),'fontsize',20,'units','normalized','horizontalalignment','center')

text(0.15,-0.1,'Twitter: @peterdevietien   Data: Truth Social','fontsize',18,'units','normalized')

%%
print('~/projects/truth_social/post/trump_followers','-dpng')