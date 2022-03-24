cca
load_data

net_delta=net_delta/1000;

nbins=1000;
histogram(net_delta,nbins)

ylim([0 15])
xlim([-20 20])

ax=gca;
ax.FontSize=15;

title('Histogram of entire election starting Nov 4th')