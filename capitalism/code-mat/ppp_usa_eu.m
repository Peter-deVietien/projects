cca

load_ppp_worldbank

%%

countries={'UnitedStates','Canada','EuropeanUnion','China'};
legendstr={'United States','Canada','European Union','China'};
nc=numel(countries);

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%%
for i=1:nc
    ppp=t.(countries{i});
    
    hold on
    plot(t.Year,ppp,'linewidth',4)
    hold off

end


ax=gca;
ax.FontSize=15;
grid on

ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;

y_lim=[0 70000];
ylim(y_lim)
yticks=ax.YTick;

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YAxis(2).Color='k';
ylim(y_lim)
ytickformat('%,.0d')
ax.YAxis(2).Exponent=0;

lgn=legend(legendstr,'fontsize',14);
lgn.Position=[0.1417 0.6855 0.2367 0.2122];

tstr=sprintf('PPP GDP Per Capita');
title(tstr,'fontsize',18)

t1=text(0.51,-0.111,'Twitter: @peterdevietien   Data: WorldBank','fontsize',12,'units','normalized');


filename='ppp_usa_eu';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')