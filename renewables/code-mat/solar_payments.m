cca

ppw=4.5;



ae=1200*1.06.^[1:30];

sumae=cumsum(ae);

plot(sumae)


hold on
plot([0 30],[1 1]*36000,'k--')
plot([0 30],[1 1]*29000,'k--')
hold off

ax=gca;
ax.FontSize=15;

ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;

ylim([0 50000])