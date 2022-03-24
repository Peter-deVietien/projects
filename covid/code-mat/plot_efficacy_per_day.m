function plot_efficacy_per_day(ndays)

efficacy=[];

for i=0:ndays
    efficacy(i+1)=efficacy_per_day(i);
end

plot([0:ndays],efficacy,'linewidth',4)
grid on
xlabel('Days')
ylabel('Efficacy')
title('Efficacy vs time')
ax=gca;
ax.FontSize=18;
fig=gcf;
fig.Position=[440 514 636 284];

print('post/efficacy-vs-time','-dpng')
end