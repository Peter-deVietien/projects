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

%%

sel=find(dwti.dates_close<datetime(2020,1,1));

sel2=find((dwti.dates_close<datetime(2014,1,1)) & (dwti.dates_close>datetime(2013,1,1)));


c05=polyfit(dwti.close(sel),dxes.close(sel),1);
line05 = polyval(c05,dwti.close(sel));

c20=polyfit(dwti.close(sel(end):end),dxes.close(sel(end):end),1);
line20 = polyval(c20,dwti.close(sel(end):end));

%% Plot last 30 days
hold on
%
scatter(dwti.close,dxes.close)
scatter(dwti.close(sel(end):end),dxes.close(sel(end):end),'m')
%
plot(dwti.close(sel),line05,'linewidth',3,'color','red')
plot(dwti.close(sel(end):end),line20,'linewidth',3,'color','cyan')
%
plot([dwti.close(end) dwti.close(end)],[0 1200],'r--','linewidth',3)

hold off

%%
grid on
ax=gca;
ax.FontSize=18;

xlim([0 150])

xlabel('US Crude WTI $/bl')
ylabel('$OIH Stock Price')

title_str=sprintf('$OIH vs $WTI Crude: 2001-2021');
title(title_str)

lgn=legend('Day in 2001-2019','Day in 2020-Present',...
    sprintf('y=%.1fx+%.0f',c05(1),c05(2)),...
    sprintf('y=%.1fx+%.0f',c20(1),c20(2)),datestr(now,'mmm-dd-yyyy'));


lgn.Position=[0.6617 0.1283 0.3150 0.3145];
%%
fig=gcf;
fig.Position(3)=1200/2;
fig.Position(4)=675/2;

print('~/projects/stock/post/OIH_scatter_WTI','-dpng')