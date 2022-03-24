clear
close all

ticker='CL=F';

dwti=load_ticker_data(ticker);

ticker='OIH';

dxes=load_ticker_data(ticker);

%% Trim longer


if numel(dwti.dates_close)>numel(dxes.dates_close)
    dwti.dates_close=dxes.dates_close;
    dwti.close=dwti.close(end-numel(dxes.close)+1:end);
end

%% Adjust for inflation

if 1
   k=readtable('~/projects/oil/data/CPIAUCSL.csv');
   k.DATE(end+1)=datetime(k.DATE(end)+calmonths(1));
   k.CPIAUCSL(end)=k.CPIAUCSL(end-1)*(1+.07/12);
   
   k.DATE(end+1)=datetime(k.DATE(end)+calmonths(1));
   k.CPIAUCSL(end)=k.CPIAUCSL(end-1)*(1+.07/12);
   
   k.CPIAUCSL=k.CPIAUCSL/k.CPIAUCSL(end);
    
   nk=numel(k.DATE);
   for i=1:nk
       sel=(dxes.dates_close.Month==k.DATE(i).Month)&(dxes.dates_close.Year==k.DATE(i).Year);
       dxes.close(sel)=dxes.close(sel)/k.CPIAUCSL(i);
       
       sel=(dwti.dates_close.Month==k.DATE(i).Month)&(dwti.dates_close.Year==k.DATE(i).Year);
       dwti.close(sel)=dwti.close(sel)/k.CPIAUCSL(i);
   end
   
   
   
end

%%

sel=find(dwti.dates_close<datetime(2020,1,1));

sel2=find((dwti.dates_close<datetime(2014,1,1)) & (dwti.dates_close>datetime(2013,1,1)));
trendx=[0:0.1:200];

c01=polyfit(dwti.close(sel),dxes.close(sel),1);
line01 = polyval(c01,trendx);

c20=polyfit(dwti.close(sel(end):end),dxes.close(sel(end):end),1);
line20 = polyval(c20,trendx);

%% Plot last 30 days
hold on
%
l(1)=scatter(dwti.close,dxes.close);
l(2)=scatter(dwti.close(sel(end):end),dxes.close(sel(end):end),'m');
%
l(3)=plot(trendx,line01,'linewidth',4,'color','red');
l(4)=plot(trendx,line20,'linewidth',4,'color','cyan');

it=find(trendx>dwti.close(end),1,'first');

p1=plot([0 trendx(it)],[1 1]*line01(it),'r--','linewidth',2);
p2=plot([0 trendx(it)],[1 1]*line20(it),'c--','linewidth',2);

p1.Color(4)=1;
p2.Color(4)=1;

%
l(5)=plot([dwti.close(end) dwti.close(end)],[0 2200],'g--','linewidth',3);

%
scatter(dwti.close(end),dxes.close(end),700,'x','linewidth',5,'markerfacecolor','m')

sel=(dwti.close>dwti.close(end)*0.97) & (dwti.close<dwti.close(end)*1.03);

scatter(dwti.close(sel),dxes.close(sel),'g')

hold off

%%
grid on
ax=gca;
ax.FontSize=18;
ax.YTick=0:200:2200;
ax.XTick=0:20:200;

xlim([0 200])
ylim([0 2000])

xlabel('WTI Crude $/bl')
ylabel('$OIH Stock Price')

title_str=sprintf('$OIH vs $WTI Crude: 2001-2022\nInflation Adjusted');
title(title_str)
% 
% lgn=legend('Day in 2001-2019','Day in 2020-Present',...
%     sprintf('y=%.1fx+%.0f',c05(1),c05(2)),...
%     sprintf('y=%.1fx+%.0f',c20(1),c20(2)),datestr(now,'mmm-dd-yyyy'));
% 
lgn=legend(l,{'Day in 2001-2019',...
    'Day in 2020-Present',...
    sprintf('2001-2019 Trend'),...
    sprintf('2020-Present Trend'),...
    sprintf('%s: $%.2f',datestr(dwti.dates_close(end),'mmm-dd-yyyy'),dwti.close(end))});

text(0.7,-0.1,'Twitter: @peterdevietien','fontsize',17,'units','normalized')


lgn.Position=[0.1364 0.7599 0.3730 0.1549];
%%
fig=gcf;
fig.Position=[476 131 715 735];
% fig.Position(3)=1200/2;
% fig.Position(4)=675/2;

print('~/projects/stock/post/OIH_scatter_WTI_infl_adj','-dpng')