clear
close all

ticker1='VGT';
d1=load_ticker_data(ticker1);

d1.dates=d1.dates_full;
d1.price=d1.price;

ticker2='VDE';
d2=load_ticker_data(ticker2);

d2.dates=d2.dates_full;
d2.price=d2.price;

%%

t1i=interp1(d1.dates,d1.price,d2.dates);
ratio=t1i./d2.price;

k=find(~isnan(ratio),1,'last');

yyaxis left
plot(d2.dates,ratio,'b-','linewidth',3)

grid on

xlim([datetime(2021,1,1) datetime])

ylabel('Tech/Energy Ratio','color','blue')
ax1=gca;
set(ax1,'ycolor','blue')
%set(gca,'yticklabels',[])

%%
yyaxis right

load_owid_data

country='World';
dma=7;
death_scale=1;
sel=ismember(t.location,country);

dates=t.date(sel);

seln=isnan(t.new_cases_per_million);
t.new_cases_per_million(seln)=0;
cases=moving_average(dates,t.new_cases_per_million(sel),dma);
hosps=moving_average(dates,t.hosp_patients_per_million(sel),dma);
deaths=moving_average(dates,t.new_deaths_per_million(sel),dma)*death_scale;

hold on
plot(dates,deaths,'r-','linewidth',3)
hold off

ylabel('Global COVID Deaths','color','red')
set(gca,'ycolor','red')
%set(gca,'yticklabels',[])

ax=gca;
thinnedxlabels=ax.XTickLabel(1:2:end);
thinnedxticks=ax.XTick(1:2:end);

set(gca,'xtick',thinnedxticks)
set(gca,'xticklabel',thinnedxlabels)

%%
ax=gca;
ax.FontSize=22;
fig=gcf;
% fig.Position=[53 239 1200*2/3 675*2/3];
fig.Position=[-1005 288 800 450];

legend('Ratio of Tech/Energy Stocks *','Global COVID Deaths **')

title('Tech and Energy Stocks vs COVID')

txt0=text(datetime(2021,9,15),1.76,sprintf('  Last: %s',datestr(date,'mmm dd')),'fontsize',15);
txt1=text(datetime(2021,9,15),1.7,'* Ratio = $VGT/$VDE','fontsize',15);
txt2=text(datetime(2021,9,15),1.64,'** 7 Day Moving Average','fontsize',15);
txt3=text(datetime(2021,9,15),1.58,'@peterdevietien','fontsize',15);

%%
pngname=sprintf('~/projects/stock/post/tech_energy_deaths');
print(pngname,'-dpng')
pngname=sprintf('~/projects/covid/post/omicron/tech_energy_deaths');
print(pngname,'-dpng')