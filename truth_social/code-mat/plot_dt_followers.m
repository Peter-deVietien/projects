cca

load_dt_followers

%%

b1=bar(dates,followers,'b');
b1.EdgeColor='b';


%%
grid on
ax=gca;
ax.FontSize=20;
ax.XAxis.TickLabelFormat='MMM dd';




ylabel('Trump Followers [thousands]')

title('Number of Followers Trump has on Truth Social')

fig=gcf;
fig.Position=[476 330 709 536];

yl=ylim;
%ylim([0 ])

xl=xlim;
xlim([xl(1) xl(2)+caldays(3)])


text(0.15,-0.1,'Twitter: @peterdevietien   Data: Truth Social','fontsize',16,'units','normalized')

%%
print('~/projects/truth_social/post/trump_followers','-dpng')