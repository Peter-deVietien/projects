cca

[rdates,receipts]=load_fred_series('MTSR133FMS');

[edates,expends]=load_fred_series('FGEXPND');

%%
fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

lw=1.5;

plot(rdates,receipts/1e3,'linewidth',lw);
hold on
plot(edates,expends/12,'linewidth',lw);
hold off

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[0:100:900];
ax.YTick=yticks;

y_lim=[0 900];
ylim(y_lim);

ylabel('Monthly Federal Flows [USD Billions]')

yyaxis right

ax=gca;
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';

%%

lgn=legend('Receipts','Expenditures');
lgn.Position=[0.1417 0.8012 0.1917 0.1024];

title(['U.S. Federal Tax Revenue and Expenses per month'])

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(rdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(1980,1,1) datetime(2024,1,1)])

%%

print('~/projects/stock/post/federal_receipts_expenditures','-dpng')