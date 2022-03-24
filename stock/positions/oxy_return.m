cca

ticker='OXY';

load_ticker_data

%%
x_lim=[10 55];
y_lim=[-800 5500];

todays_price=close(end);

%% Strike, number of contracts, avg price paid
load_oxy_calls

%% Total initial investment
cost=sum(calls(:,2).*calls(:,3))*100;

%% Return at expiration for various prices

price=10:.01:100;
achieved_price=10:0.01:todays_price;
nap=numel(achieved_price);

revenue=sum(max(0,price-calls(:,1)).*calls(:,2)*100,1);
value_total = (revenue - cost)/1000;

[~,half_ind]=find(value_total>-cost/2000,1,'first');
[~,zerox_ind]=find(value_total>0,1,'first');
[~,onex_ind]=find(value_total>cost/1000,1,'first');
[~,twox_ind]=find(value_total>2*cost/1000,1,'first');
[~,threex_ind]=find(value_total>3*cost/1000,1,'first');
[~,fivex_ind]=find(value_total>5*cost/1000,1,'first');
[~,tenx_ind]=find(value_total>10*cost/1000,1,'first');
[~,m1_ind]=find(value_total>1e3,1,'first');
[~,m2_ind]=find(value_total>2e3,1,'first');
[~,buff_ind]=find(price>62.5,1,'first');

plot(price,value_total,'linewidth',8);
hold on
plot(price(1:nap),value_total(1:nap),'linewidth',8,'color','red')

plot([1 1]*price(zerox_ind),[0,max(value_total)*1.5],'--','linewidth',3,'color',[0 0 0])
plot([1 1]*price(onex_ind),[0,value_total(onex_ind)],'--','linewidth',3,'color',[0 0 1])
plot([1 1]*price(twox_ind),[0,value_total(twox_ind)],'--','linewidth',3,'color',[0 0 1])
plot([1 1]*price(threex_ind),[0,value_total(threex_ind)],'--','linewidth',3,'color',[0 0 1])
plot([1 1]*price(fivex_ind),[0,value_total(fivex_ind)],'--','linewidth',3,'color',[0 0 1])
plot([1 1]*price(tenx_ind),[0,value_total(tenx_ind)],'--','linewidth',3,'color',[0 0 1])

plot([min(price) max(price)*1.2],[1 1]*min(value_total),'k--')
plot([min(price) max(price)*1.2],[1 1]*0,'k-','linewidth',3)
hold off


x1x=price(onex_ind)-1;
x1y=value_total(onex_ind)+0.1*(y_lim(2)-value_total(onex_ind));
x1str='1x';
text(x1x,x1y,x1str,'fontsize',20)


x3x=price(threex_ind)-1;
x3y=value_total(threex_ind)+0.1*(y_lim(2)-value_total(threex_ind));
x3str='3x';
text(x3x,x3y,x3str,'fontsize',20)

x5x=price(fivex_ind)-1;
x5y=value_total(fivex_ind)+0.1*(y_lim(2)-value_total(fivex_ind));
x5str='5x';
text(x5x,x5y,x5str,'fontsize',20)

x10x=price(tenx_ind)-1;
x10y=value_total(tenx_ind)+0.2*(y_lim(2)-value_total(tenx_ind));
x10str='10x';
text(x10x,x10y,x10str,'fontsize',20)

buffx=price(buff_ind)-20;
buffy=value_total(buff_ind)+0.4*(y_lim(2)-value_total(buff_ind));
buffstr=sprintf('Buffet Return: $%.1f',value_total(buff_ind));
%text(buffx,buffy,buffstr,'fontsize',20)

hold on
plot([0 90],[1 1]*value_total(buff_ind),'k--','linewidth',2)
hold off

ii_str=sprintf('Initial Investment: $%.3f',cost/1000);
ii_str=regexprep(ii_str,'\.',',');
ii_x=12;
ii_y=-400;
text(ii_x,ii_y,ii_str,'fontsize',20)

%%
grid on

fig=gcf;
fig.Position=[440 296 676 502];

ylabel('Thousands USD')
xlabel('OXY Stock Price')

nz_str=sprintf('Break Even\n$%.2f\n(0x ROI)',price(zerox_ind));
nz_x=18.5;
nz_y=200;
%text(nz_x,nz_y,nz_str,'fontsize',22,'color',[0 0 0])

% ox_str=sprintf('100%% ROI\n    $%.2f',price(onex_ind));
% ox_x=32;
% ox_y=650;
% text(ox_x,ox_y,ox_str,'fontsize',22,'color',[0 0 1])
% th=annotation('textarrow',[.38,.445],[.45,.30],'String',nz_str,'fontsize',22,...
%     'horizontalalignment','center','verticalalignment','middle');
% th=annotation('textarrow',[.51,.51],[.48,.37],'String','1x ROI','fontsize',18);
% th=annotation('textarrow',[.58,.58],[.58,.51],'String','3x ROI','fontsize',18);
% th=annotation('textarrow',[.65,.65],[.73,.65],'String','5x','fontsize',18);
% th=annotation('textarrow',[.75,.79],[.7,.8],'String','10x','fontsize',18);



remaining=round(days(datetime(2021,01,15)-datetime())/7,0);
title_str=sprintf('Value of %d Jan 2021 OXY calls\n%d Weeks Remaining\n OXY Price on %s: $%.2f',sum(calls(:,2)),remaining,[datestr(dates(end),'mmmm dd'),'th'],close(end));
title(title_str,'fontsize',17)

lgs=legend('Potential Return','Current Return','location','west');
lgs.FontSize=20;

xlim(x_lim)

ylim(y_lim)

ax=gca;
ax.FontSize=22;

fig=gcf;
fig.Position=[100 220 837 534];

print('OXY_return','-dpng')

fprintf('halfx: %f\n',price(half_ind));
fprintf('zerox: %f\n',price(zerox_ind));
fprintf('onex: %f\n',price(onex_ind));
fprintf('threex: %f\n',price(threex_ind));
fprintf('fivex: %f\n',price(fivex_ind));
fprintf('tenx: %f\n',price(tenx_ind));
fprintf('1 million: %f\n',price(m1_ind));
fprintf('2 million: %f\n',price(m2_ind));
