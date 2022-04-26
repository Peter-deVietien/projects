cca

[cdates,cashflow]=load_mro_cashflow_ops;
[sdates,shares]=load_mro_basic_weighted_shares;

cdates=cdates;
sdates=sdates;

%%
x_lim=[datetime(2012,1,1) datetime(2022,6,1)];

subplot(3,1,1)
bar(cdates,cashflow/1e9)

title('$MRO Cashflow from Operations','fontsize',16)
ylabel('CF ops [$billions]')
xlim(x_lim)

subplot(3,1,2)
bar(sdates,shares/1e6)

title('$MRO number of shares','fontsize',16)
ylabel('Share Count [millions]')
xlim(x_lim)

ylim([600 900])

subplot(3,1,3)
bar(sdates,cashflow./shares)

title('$MRO CF ops per share','fontsize',16)
ylabel('dollars per share')
xlim(x_lim)

fig=gcf;
fig.Position=[286.2000 149.8000 1.0704e+03 612.2000];

%%
if 1
    t=table(cdates,cashflow);
    writetable(t,'post/mro_cashflow_ops.csv');

    t=table(sdates,shares);
    writetable(t,'post/mro_basic_weighted_shares.csv');

    t=table(sdates,cashflow./shares);
    writetable(t,'post/mro_cashflow_per_share.csv');


end

%%
print('post/cashflow_per_share','-dpng')
