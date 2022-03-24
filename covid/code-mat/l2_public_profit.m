cca

%% Revenue
pphour=13;
power=20;

%% CAPEX
equipment=25000;
installation=10000;

capex=equipment+installation;

deprec_yrs=10;

%% OPEX
annual_cost=[];
hours=0:0.01:15;

%% Payroll
nemp=20;
avg_sal=80000;
chargers=1000;

payroll=nemp*avg_sal/chargers;

%% Rent
rent=8000*12/chargers;

for i=1:numel(hours)
    hr=hours(i);

    %OPEX
    electricity=0.12*power*hr*365;
    maintenance=(2+0.10*hr)*365;
    internet=30*12;
    
    opex(i)=electricity+maintenance+internet + payroll + rent;
    
    annual_cost(i)=capex/deprec_yrs + opex(i);
    
    annual_revenue(i)=pphour*hr*365;
end

profit=annual_revenue-annual_cost;
plot(hours,profit,'linewidth',5)

y_lim=ylim;
grid on
ax=gca;
ax.FontSize=20;
xlabel('Hours daily charging')
ylabel('Profit $CAD')
title('Annual Profit Per EV Charger')

%%
ind=find(profit>0,1,'first');

hold on
plot([1 1]*hours(ind),[-500000 3500000],'linewidth',3)
hold off
ylim(y_lim)

text(hours(ind)+0.5,y_lim(2)*.85,sprintf('Breakeven hours: %.1f',hours(ind)),'fontsize',20);
text(hours(ind)+0.5,y_lim(2)*.75,sprintf('Annual capex: $%.1f',capex/deprec_yrs),'fontsize',20);
text(hours(ind)+0.5,y_lim(2)*.65,sprintf('Breakeven opex: $%.1f',opex(ind)),'fontsize',20);
