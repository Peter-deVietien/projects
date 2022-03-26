cca

load_ppp_worldbank

%%

countries={'UnitedStates','France','EuropeanUnion','China'};
legendstr={'United States','France','European Union','China'};
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
lgn.Position=[0.1295 0.7333 0.1977 0.1914];

tstr=sprintf('WorldBank PPP GDP Per Capita');
title(tstr,'fontsize',25)

text(0.5,-0.1,'Twitter: @peterdevietien   Data: WorldBank','fontsize',17,'units','normalized')


filename='ppp_usa_eu';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')