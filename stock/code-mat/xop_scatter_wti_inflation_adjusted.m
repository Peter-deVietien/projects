clear
close all

ticker='CL=F';

dwti=load_ticker_data(ticker);

ticker='XOP';

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
scatter(dwti.close,dxes.close)
scatter(dwti.close(sel(end):end),dxes.close(sel(end):end),'m')
%
plot(trendx,line01,'linewidth',3,'color','red')
plot(trendx,line20,'linewidth',3,'color','cyan')
%
plot([dwti.close(end) dwti.close(end)],[0 1200],'r--','linewidth',1)

%
scatter(dwti.close(end),dxes.close(end),700,'x','linewidth',5,'markerfacecolor','m')

sel=(dwti.close>dwti.close(end)*0.97) & (dwti.close<dwti.close(end)*1.03);

scatter(dwti.close(sel),dxes.close(sel),'r')

hold off

%%
grid on
ax=gca;
ax.FontSize=18;
ax.YTick=0:50:400;
ax.XTick=0:20:200;

xlim([0 200])
ylim([0 400])

xlabel('WTI Crude $/bl')
ylabel('$XOP Stock Price')

title_str=sprintf('Inflation Adjusted\n$XOP vs $WTI Crude: 2001-2021');
title(title_str)
% 
% lgn=legend('Day in 2001-2019','Day in 2020-Present',...
%     sprintf('y=%.1fx+%.0f',c05(1),c05(2)),...
%     sprintf('y=%.1fx+%.0f',c20(1),c20(2)),datestr(now,'mmm-dd-yyyy'));
% 
lgn=legend('Day in 2001-2019',...
    'Day in 2020-Present',...
    sprintf('2001-2019 Trend'),...
    sprintf('2020-Present Trend'),...
    sprintf('%s: $%.2f',datestr(dwti.dates_close(end),'mmm-dd-yyyy'),dwti.close(end)));

text(155,-30,'@peterdevietien','fontsize',17)

lgn.Position=[0.5061 0.1378 0.3730 0.1549];
%%
fig=gcf;
fig.Position=[476 133 587 733];
% fig.Position(3)=1200/2;
% fig.Position(4)=675/2;

print('~/projects/stock/post/XOP_scatter_WTI_infl_adj','-dpng')