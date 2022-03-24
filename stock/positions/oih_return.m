clear
close all

ticker='OIH';

d=load_ticker_data(ticker);

%%
todays_price=d.close(end);

%% Strike, number of contracts, avg price paid
load_oih_calls

%% Total initial investment
cost=sum(calls(:,2).*calls(:,3))*100;

%% Return at expiration for various prices

price=100:.1:1000;
achieved_price=100:0.01:todays_price;
nap=numel(achieved_price);

revenue=sum(max(0,price-calls(:,1)).*calls(:,2)*100,1);
value_total = (revenue - cost)/1000;

plot(price,value_total,'linewidth',8);

%%
grid on

fig=gcf;
fig.Position=[-972 263 676 502];

ylabel('Thousands USD')
xlabel('OIH Stock Price')



remaining=round(days(datetime(2023,01,15)-datetime())/7,0);
title_str=sprintf('Value of %d Jan 2023 OIH calls\n%d Weeks Remaining\n OIH Price on %s: $%.2f',sum(calls(:,2)),remaining,datestr(d.dates(end),'mmmm dd'),d.close(end));
title(title_str,'fontsize',17)

lgs=legend('Return at Expiration','location','west');
lgs.FontSize=20;


ax=gca;
ax.FontSize=22;

xlim([100 500])
ylim([-1000 6000])

ytickformat('%,.0d')

print('OIH_return','-dpng')

if 1
    figure
    plot_price
    hold on
    plot([datetime(2023,1,15) datetime(2023,1,15)],[0 1500])
    plot([datetime datetime(2023,1,15)],[d.close(end) 320])
    hold off
end
