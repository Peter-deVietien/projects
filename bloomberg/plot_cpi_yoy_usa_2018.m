cca

[dates,cpi]=load_cpi_yoy_usa;

%%
fig=gcf;
fig.Position=[75.8000 342 972.2000 420];

p=plot([dates(1) dates(end)],[0 0],'k-');
p.Color(4)=0.3;

hold on
p=plot(dates,cpi,'b-');
%plot([dates(1) dates(end)],[1 1]*cpi(end),'r-');
plot([datetime(2022,2,21) datetime(2022,2,21)],[0 10],'k--')
plot([datetime(2021,1,1) datetime(2021,1,1)],[0 10],'k--')
hold off

txt1=text(datetime(2020,12,27),4.4,'Biden Inagurated','horizontalalignment','right','fontsize',14)
txt2=text(datetime(2022,2,18),4.4,['Feb 21st',newline,'Russia Invades'],'horizontalalignment','right','fontsize',14)

%%
ax=gca;
ax.FontSize=15;
grid on
ax.XGrid='off';

yticks=[0:1:10];

ylim([0 10])

ylbl=[];
for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.0f%%',yticks(i))}];
end

ax.YTick=yticks;
ax.YTickLabel=ylbl;
ax.Position=[0.1300 0.1300 0.7750 0.7745];

xl=xlim;
xlim([datetime(2018,1,1) xl(2)+calmonths(1)])

ax=gca;
xticks=ax.XTickLabel;
nx=numel(xticks);
xlbl=[];
for i=1:nx
    xlbl=[xlbl {sprintf('%s ''%s',xticks{i}(1:3),xticks{i}(7:8))}];
end

ax.XTickLabel=xlbl;


title('U.S. Year over Year Inflation Rate','fontsize',18)

lgn=legend(p,'U.S. Consumer Price Index');
lgn.Position=[0.1343 0.7565 0.2770 0.0629];

txt=text(0.625,-0.129,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',11,'units','normalized');

%%
print('post/cpi_yoy_usa_2018','-dpng')