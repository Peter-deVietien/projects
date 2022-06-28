cca

[dm1,m1]=load_fred_series('WM1NS');
[dm2,m2]=load_fred_series('WM2NS');
[dm3,m3]=load_fred_series('WM3NS');
[dm3b,m3b]=load_fred_series('MABMM301USM189S');

%%

lw=1;

semilogy(dm1,m1/1e3,'linewidth',lw);

hold on
semilogy(dm2,m2/1e3,'linewidth',lw);
semilogy(dm3,m3/1e3,'linewidth',lw);
semilogy(dm3b,m3b/1e12,'linewidth',lw);
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[1,2.5,5,10,20];
ax.YTick=yticks;

y_lim=[0.7 33];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

lgn=legend('M1','M2 (~equals M3)','M3 Discontinued','M3');
lgn.Position=[0.1550 0.7019 0.2517 0.1944];

title('U.S. Monetary Aggregates')

%%
%t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

xl=xlim;
xlim([datetime(2000,1,1) datetime(2023,1,1)])

%%

print('~/projects/stock/post/m1_m2_m3_zoomed','-dpng')