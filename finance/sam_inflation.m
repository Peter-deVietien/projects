cca

dates=datetime(2020,23,11):caldays(1):datetime();

[d,infl]=inflation_vs_t(dates);

plot(dates,1000*infl/infl(1));

ax=gca;
ax.FontSize=15;