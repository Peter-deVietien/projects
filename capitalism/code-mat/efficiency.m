int_hr=960;
tot_hr=80e3;
eff_gain=5;

ahr=[0:int_hr:tot_hr];
ehr=[];
ehr(1)=0;

nint=numel(ahr);

for i=2:nint
    ehr(i)=int_hr*(1+eff_gain/100)^i;
end

ehrcs=cumsum(ehr);

semilogy(ahr,ehrcs,'b','linewidth',3)
text(ahr(end)*.77,ehrcs(end)*1.2,sprintf('%.3g hrs',ehrcs(end)),...
    'fontsize',20)

%%
int_hr=960;
tot_hr=80e3;
eff_gain2=15;

ahr=[0:int_hr:tot_hr];
ehr2=[];
ehr2(1)=0;

nint=numel(ahr);

for i=2:nint
    ehr2(i)=int_hr*(1+eff_gain2/100)^i;
end

ehr2cs=cumsum(ehr2);

hold on
semilogy(ahr,ehr2cs,'g','linewidth',3)
hold off
text(ahr(end)*.77,ehr2cs(end)*1.2,sprintf('%.3g hrs',ehr2cs(end)),...
    'fontsize',20)

%%
lgn_str={sprintf('%.1f %% improvement every 6 months',eff_gain),...
    sprintf('%.1f %% improvement every 6 months',eff_gain2)};

legend(lgn_str,'location','northwest')

title_str=sprintf('Effective hours worked over a career \nwith different improvement rates','fontsize',20);
title(title_str)

ax=gca;
ax.FontSize=20;
ylabel('Effective hours worked')
xlabel('Actual hours worked')

grid on
ylim([1e3 1e10])
text(.3e4,3e7,sprintf('Effective Hour Ratio: %.1f\n(Proxy for fair total compensation)',ehr2cs(end)/ehrcs(end)),'fontsize',20)