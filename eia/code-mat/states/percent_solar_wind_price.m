cca

load eia-states-solar-wind-price.mat

states=remaining_states;
ns=numel(states);

percent=[];
price=[];
for i=1:ns
    percent(i)=(ds(i).y(end)+dw(i).y(end))/da(i).y(end)*100;
    price(i)=dp(i).y(end);
end

percent=percent(2:2:42);
price=price(2:2:42);
states=states(2:2:42);

figure
scatter(percent,price)


[spercent,inds]=sort(percent);
sstates=states(inds);

figure
b=bar(1:numel(states),spercent);

fig=gcf;
fig.Position=[476 446 1381 434];

ax=gca;
ax.XTick=1:numel(states);
ax.XTickLabel=sstates;