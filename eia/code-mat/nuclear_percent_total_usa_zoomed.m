cca

%%
series_key1='TOTAL.NUETSUS.A';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

%%
plot(d1.dates,d1.y,'linewidth',4,'color',leftycolor)

grid on

%ytickformat('%,.0d')
ax=gca;
%ax.YAxis(1).Exponent=0;
ax.FontSize=22;



fig=gcf;
fig.Position=[203 305 847 561];

%ylabel(sprintf('Percent Nuclear'))

ylim([0 12])
xlim([d1.dates(1) datetime(1977,1,1)])

%ylim([0 100])
%xlim([d1.dates(1) d1.dates(end)])


yticks=ax.YTick;

nt=numel(yticks);

yticklabels=cell(nt,1);
for i=1:nt
    yticklabels(i)={sprintf('%d%%',yticks(i))};
end

ax.YTickLabel=yticklabels;

xticks=datetime(1960,1,1):calyears(4):datetime(1982,1,1);

ax.XTick=xticks;
ax.XGrid='off';

tt=title(sprintf('Nuclear Fission\nPercent of Total U.S. Electricity'),'fontsize',30);
tt.Position=[3.7081e+03 9.8707 1.4211e-14];

%%
%text(datetime(2000,1,1),-10,'@peterdevietien  Data: EIA','fontsize',16)
text(0.6,-0.1,'Twitter: @peterdevietien   Data: EIA','fontsize',16,'units','normalized')


k={"'...a terrific thriller that incidentally raises the"
    "most unsettling questions about how safe"
    "nuclear power plants really are.'"};


% text(datetime(1965,1,1),9.3,sprintf("Roger Ebert on \n'The China Syndrome' in 1979:"),'fontsize',26,'horizontalalignment','center')
% text(datetime(1965,1,1),6.3,k,'fontsize',20,'horizontalalignment','center')

%%
print('~/projects/eia/post/nuclear_percent_total_usa','-dpng')
