cca

load_ppp_worldbank

%%

countries={'UnitedStates','Canada','EuropeanUnion','RussianFederation','China'};
legendstr={'United States','Canada','European Union','Russia','China'};
nc=numel(countries);

for i=1:nc
    ppp=t.(countries{i});
    
    hold on
    plot(t.Year,ppp,'linewidth',4)
    hold off

end


fig=gcf;
fig.Position=[476 388 865 478];

ax=gca;
ax.FontSize=17;
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

lgn=legend(legendstr,'fontsize',18);
lgn.Position=[0.2624 0.6998 0.1977 0.0994];

tstr=sprintf('WorldBank PPP GDP Per Capita');
title(tstr,'fontsize',25)

text(datetime(2014,6,1),2100,'@peterdevietien','fontsize',17)


filename='ppp_usa_eu';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')