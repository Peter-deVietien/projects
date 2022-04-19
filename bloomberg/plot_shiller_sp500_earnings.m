cca

s=load_shiller_sp500;
[dates,earnings]=load_sp500_earnings;

%%
e2=(s.earnings-s.dividends);

semilogy(s.dates,s.earnings*3,'linewidth',2)

hold on
%semilogy(s.dates,e2*3,'linewidth',2)
semilogy(dates,earnings,'linewidth',2)
hold off

grid on

ax=gca;
ax.XGrid='off';

xlim([datetime(1990,1,1) datetime(2023,1,1)])
ylim([10 1000])

lgn=legend('Shiller Earnings','Bloomberg Earnings');
lgn.Position=[0.7312 0.2130 0.1711 0.1148];

fig=gcf;
fig.Position=[488 359 939.8000 403];

%%
print('post/shiller_sp500_earnings','-dpng')