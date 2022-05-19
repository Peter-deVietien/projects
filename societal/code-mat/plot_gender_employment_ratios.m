cca

load_gender_employment_ratios

%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%%
plot(m.edates,m.ratio,'linewidth',2);

hold on
plot(f.edates,f.ratio,'linewidth',2);
hold off

%%
ylim([20 60])
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=15;

yticks=ax.YTick;

ylbl=[];
for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.0f%%',yticks(i))}];
end

ax.YTickLabel=ylbl;

lgn=legend('Male Employment Ratio','Female Employment Ratio','fontsize',15);
lgn.Position=[0.1375 0.4782 0.3625 0.1202];

title('U.S. Gender Employment Ratios')

t1=text(0.4892,0.0236,'Total of sex employed / total sex population','units','normalized','fontsize',12);
t2=text(0.472,-0.1109,'Twitter: @peterdevietien    Data: FRED and UN','units','normalized','fontsize',12);

%%

print('~/projects/societal/post/gender_employment_ratios','-dpng')