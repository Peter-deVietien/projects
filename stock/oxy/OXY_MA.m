cca

set(0,'defaultlinelinewidth',1)

%%
ticker='OXY';
plt_color='k';
plot_price

ma_days=3*365;
overlay_moving_average

%%
ticker='CL=F';
plt_color=[0.9290, 0.6940, 0.1250];
overlay_price;
overlay_moving_average;

%%
ticker='OXY';
load_ticker_data;

dday=datetime(2021,01,15);
hold on
plot([dday dday],[0,200],'k--','linewidth',4)
hold off

hold on
plot([datetime(2015,01,01) datetime(2022,01,01)],[1 1]*26.55,'k-','linewidth',2)
plot([datetime(2015,01,01) datetime(2022,01,01)],[1 1]*29.75,'b--','linewidth',2)
plot([datetime(2015,01,01) datetime(2022,01,01)],[1 1]*35.36,'m--','linewidth',2)
plot([datetime(2015,01,01) datetime(2022,01,01)],[1 1]*37.7,'g--','linewidth',2)
plot([datetime(2015,01,01) datetime(2022,01,01)],[1 1]*46.87,'r--','linewidth',2)
hold off

text(datetime(2018,07,1),26.55-1.5,'Breakeven','fontsize',20)
text(datetime(2018,07,1),29.75+2,'100%','fontsize',20)
text(datetime(2018,7,1),35.36+1,'500%','fontsize',20)
text(datetime(2018,7,1),37.7+2,'$1mn','fontsize',20)
text(datetime(2018,7,1),46.87+2,'$2mn','fontsize',20)

text(datetime(2021,01,01)-10,50,'Expiration Date','rotation',90,'fontsize',20);
 
%%
hold on
plot([datetime(2019,08,15) datetime(2025,08,15)],[1 1]*62.5,'k--','linewidth',2)
%scatter(datetime(2020,08,15),62.5,200,'filled','black')
scatter(datetime(2019,08,15),62.5,200,'filled','black')
hold off

btx=datetime(2019,10,01);
bty=70;
btstr=sprintf('Buffet Aug 2020 \nCall Option Price: $62.5');
text(btx,bty,btstr,'fontsize',20)

%
x_buff=datetime(2019,08,15);
ind_buff=find(dates_full>x_buff,1,'first');
y_buff=price(ind_buff);
%
npl=numel(h);
hold on
h(npl+1)=scatter(x_buff,y_buff,500,'filled','red');
hold off
lgs=[lgs {'Buffet Buys $10bn'}];

%%
load_covid_data
doffset=0;
floor=0;
scale=0.39;


hosp_factor=1/1000*scale;
icu_factor=1/250*scale;
death_factor=1/33*scale;

ma_days=10;
current_hospitalized=floor+moving_average(dates,current_hospitalized*hosp_factor,ma_days);
current_icu=floor+moving_average(dates,current_icu*icu_factor,ma_days);
increase_deaths=floor+moving_average(dates,increase_deaths*death_factor,ma_days);

npl=numel(h);

hold on
h(npl+1)=plot(dates+doffset,current_hospitalized,'color','blue','linewidth',2);
hold off
lgs=[lgs {sprintf('Norm''d Hospitalized')}];
% 
% hold on
% h(npl+2)=plot(dates,current_icu,'color','red','linewidth',2);
% hold off
% lgs=[lgs {sprintf('Norm''d ICU')}];

hold on
h(npl+2)=plot(dates+doffset,increase_deaths,'color','m','linewidth',2);
hold off
lgs=[lgs {sprintf('Norm''d Daily Death')}];



%%

xlim([datetime(2017,01,01) datetime(2021,02,01)])
ylim([0 80])

grid on

title(sprintf('OXY Investment Return Schedule, as of %s',dates(end)))

fig=gcf;
fig.Position=[50 150 1200 600];

[lgh,icons]=legend(h,lgs);

lgh.Position(1)=0.2;
lgh.Position(2)=0.12;
icons(16).Children.MarkerSize=20;

ylabel('OXY and Crude Price')

print('OXY_MA','-dpng')

