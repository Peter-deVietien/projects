cca

tp=[1:100:1e9];

l2=log2(tp);

l10=log10(tp);

plot(tp,(tp).^(1/2)/50)

for i=[1,5,10,20,100]

    hold on
    plot([1/10 (i*50)^2],[i i])
    plot([1 1]*(i*50)^2,[1/10 i])
    hold off
end

ax=gca;
ax.XScale='log';
ax.YScale='log';
ax.FontSize=13;

xlim([1e-1 1e7])
ylim([1e-1 100])

xlabel('Cumulative amount of taxes paid [$]')
ylabel('Total number of votes')

print('../post/voting_taxes','-dpng')