
cca

delta=12200;
gamma=215;

price=1:200;

profit=price*delta + 1/2*gamma*price.^2;

subplot(1,2,1)

plot(price,profit,'linewidth',4)

%%
grid on
ylabel("Profit from $OIH")
xlabel("Points above Today's Price")

ax=gca;
ax.FontSize=18;


ax.YAxis.Exponent=0;
ytickformat('%,.0d')

ax.YTick=[1:2:90]*1e5;

fig=gcf;
fig.Position=[680 109 583 757];

%%
clear
subplot(1,2,2)
plot_oih