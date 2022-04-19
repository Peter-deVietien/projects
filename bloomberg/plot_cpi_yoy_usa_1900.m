cca

[dates,cpi]=load_cpi_yoy_usa;

%%
fig=gcf;
fig.Position=[75.8000 342 972.2000 420];

p=plot([dates(1) dates(end)],[0 0],'k-');
p.Color(4)=0.3;

hold on
plot(dates,cpi,'b-')
plot([dates(1) dates(end)],[1 1]*cpi(end),'r-');
hold off

%%
ax=gca;
ax.FontSize=15;
grid on
ax.XGrid='off';

yticks=[-20:4:24];

ylim([-20 24])

ylbl=[];
for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.0f%%',yticks(i))}];
end

ax.YTick=yticks;
ax.YTickLabel=ylbl;
ax.Position=[0.1300 0.1300 0.7750 0.7745];

xl=xlim;
xlim([xl(1) xl(2)+calmonths(12)])

title('Historical U.S. CPI','fontsize',18)

txt=text(0.625,-0.129,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',11,'units','normalized');

%%
print('post/cpi_yoy_usa_1900','-dpng')