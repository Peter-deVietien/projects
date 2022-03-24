bar(eff_bin)
ax=gca;
ax.FontSize=15;
xlabel('bins of 1000 people')
ylabel('Avg efficacy of each bin')
tstr=sprintf('Days of vaccination campaign: %d',d);
title(tstr)
ylim([0 1])
grid on
drawnow