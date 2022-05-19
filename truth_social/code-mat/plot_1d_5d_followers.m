cca

load_dt_followers

%%
ndays1=30;
ndays2=7;

sel1=dates<datetime(2022,4,21);
sel2=dates>datetime(2022,4,22);

dates1=dates(sel1);
dates2=dates(sel2);

followers1=followers(sel1);
followers2=followers(sel2);

ndays1=days(dates1-dates1(1));
ndays2=days(dates2-dates2(1));

[yo1,mo1,x1,bo1]=least_squares(ndays1,followers1);
[yo2,mo2,x2,bo2]=least_squares(ndays2,followers2);

bardates1=dates1;
barfollowers1=followers1;

x=[-25:0.1:80];
y1=mo1*x+bo1;
lsdates1=dates1(1)+x;

y2=mo2*x+bo2;
lsdates2=dates2(1)+x;

b1=bar(bardates1,barfollowers1,'b');
b1.EdgeColor='b';
b1.BarWidth=min(b1.BarWidth,0.1);

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
per_hour1=num2cstr(round(mo1*1000,0));
per_hour2=num2cstr(round(mo2*1000,0));


%%
grid on
ax=gca;
ax.FontSize=20;

ylabel('Trump Followers [thousands]')

title('Number of Followers Trump has on Truth Social')

fig=gcf;
fig.Position=[476 330 709 536];

yl=ylim;
ylim([0 3600])

xlim([dates1(1)-days(2) dates2(end)+days(18)])

ax=gca;
ax.XTick=[datetime(2022,3,1),datetime(2022,3,15),datetime(2022,4,1),datetime(2022,4,15),datetime(2022,5,1),datetime(2022,5,15)];
ax.XTickLabel=datestr(ax.XTick,'mmm dd');

lgn=legend(p,sprintf('New Followers per Day, Before 4/20: %s',per_hour1),sprintf('New Followers per Day, After 4/20: %s',per_hour2));
lgn.Position=[0.1291 0.8197 0.5783 0.1051];
%text(0.33,0.82,sprintf('40,000/hr needed for 1m/day'),'fontsize',20,'units','normalized','horizontalalignment','center')

t=text(0.465,-0.107,'Twitter: @peterdevietien   Data: Truth Social','fontsize',15,'units','normalized');

%%
print('~/projects/truth_social/post/trump_1d_5d_followers','-dpng')