cca

ticker='TSLA';

load_data

MA_days=[60,180,365];

%% Calculate MAs
lgn=[];
avg_price=mean([open,low,high,close],2);
np=numel(avg_price);
for MA_ct=1:numel(MA_days)
    MA_day=MA_days(MA_ct);
    for i=1:np
        ind1=max(1,i-MA_day);
        v_MA(i,MA_ct)=mean(avg_price(ind1:i));
    end
    text(dates(end)+10,v_MA(end),num2str(round(v_MA(end),0)),'fontsize',20)
    lgn=[lgn,{sprintf('%d day MA',MA_day)}];
end

%%
MA_ratios=avg_price./v_MA;
plot(dates,MA_ratios,'linewidth',2)

%%
avg=mean(MA_ratios(:,3));
hold on
plot([dates(1) dates(end)],[1 1],'k')
plot([dates(1) dates(end)],[1 1]*avg,'k')
hold off

%% Adornments

grid on
t_str=sprintf('%s Moving Average Multiples',ticker);
title(t_str,'fontsize',20)
ylabel('Stock Price / Moving Average')

ax=gca;
ax.FontSize=20;

f=gcf;
f.Position=[-1744 314 1688 464];

lgnd=legend(lgn,'location','best');
lgnd.FontSize=20;

%% Save figure
save_name=sprintf('post/%s_moving_average_ratio.png',ticker);
print(save_name,'-dpng')

%% Plot last six months
a1=gca;
f2=figure;
a2 = copyobj(a1,f2);
ind=find(dates>dates(end)-182,1,'first');

xlim([dates(ind) dates(end)])

t_str=sprintf('%s Moving Average Multiples Zoomed',ticker);
title(t_str,'fontsize',20)

ax=gca;
ax.FontSize=20;

f=gcf;
f.Position=[-1744 314 688 464];

lgnd=legend(lgn,'location','best');
lgnd.FontSize=20;

%% Save figure
save_name=sprintf('post/%s_moving_average_ratio_zoomed.png',ticker);
print(save_name,'-dpng')