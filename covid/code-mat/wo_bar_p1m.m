cca
load_wo


sel=population<10e6;

country(sel)=[];
pos_tests(sel)=[];
deaths(sel)=[];
casesp1m(sel)=[];
deathsp1m(sel)=[];
tests(sel)=[];
testsp1m(sel)=[];
population(sel)=[];

sel=deathsp1m<450;

country(sel)=[];
pos_tests(sel)=[];
deaths(sel)=[];
casesp1m(sel)=[];
deathsp1m(sel)=[];
tests(sel)=[];
testsp1m(sel)=[];
population(sel)=[];

%%
[deathsp1m,indz]=sort(deathsp1m);
testsp1m=testsp1m(indz);
country=country(indz);

p1m=[deathsp1m';testsp1m'];
p1m=p1m(:);
np=numel(testsp1m);
xaxis=[1];
for i=2:np
    xaxis(i)=xaxis(i-1)+3;
end
bar(xaxis,p1m(1:2:end),1/3)

ylabel('Deaths per million')

ylim([0 1200])
xlim([xaxis(1)-1 xaxis(end)+2])
grid on

yyaxis right
hold on
bar(xaxis+1,p1m(2:2:end)/1000,1/3)
hold off

ylabel('Tests per thousand')
yyaxis left

ax=gca;
set(gca, 'XTick',xaxis+.5)
set(gca, 'XTickLabel',country)

ax.YAxis(1).Color = [0, 0.4470, 0.7410]	;

ax.FontSize=20;
fig=gcf;
fig.Position=[1 65 1440 635];

ax.OuterPosition(1)=-0.07;
ax.OuterPosition(3)=1.07;

title_str=sprintf('Worst Hit Countries with Population over 10 million\nData from Worldometers.com as of August 1st, 2020');
title(title_str)

text(4,820,'@peterdevietien','fontsize',25,'color',[0.7 0.7 0.7])

print('worst_hit_p1m','-dpng')