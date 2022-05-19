cca

[dates,cpi]=load_cpi_yoy_usa;

%%
fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p=plot([dates(1) dates(end)],[0 0],'k-');
p.Color(4)=0.3;

hold on
p=plot(dates,cpi,'b-','linewidth',3);
%plot([dates(1) dates(end)],[1 1]*cpi(end),'r-');
plot([datetime(2022,2,21) datetime(2022,2,21)],[0 10],'k--')
plot([datetime(2021,1,1) datetime(2021,1,1)],[0 10],'k--')
hold off

txt1=text(datetime(2020,12,22),6.5,'Biden Inagurated','horizontalalignment','right','fontsize',20);
txt2=text(datetime(2022,2,13),2,['Feb 21st',newline,'Russia',newline,'Invades'],'horizontalalignment','right','fontsize',20);

%%
ax=gca;
ax.FontSize=18;
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
    if ~isempty(xticks{i})
        xlbl=[xlbl {sprintf('%s ''%s',xticks{i}(1:3),xticks{i}(7:8))}];
    else
        xlbl=[xlbl {''}];
    end
end

%ax.XTickLabel=xlbl';


title('U.S. Inflation Rate','fontsize',24)

lgn=legend(p,'U.S. Consumer Price Index');
lgn.Position=[0.1370 0.8285 0.3967 0.0712];

txt3=text(0.478,-0.138,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',12,'units','normalized');

%%
print('post/cpi_yoy_usa_2018_twtr','-dpng')