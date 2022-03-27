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
plot(d1.dates,d1.y,'linewidth',4,'color',leftycolor)

%%
grid on
ax=gca;
ax.FontSize=22;

fig=gcf;
fig.Position=[203 305 847 561];

ylim([0 30])

yticks=ax.YTick;

nt=numel(yticks);

yticklabels=cell(nt,1);
for i=1:nt
    yticklabels(i)={sprintf('%d%%',yticks(i))};
end

ax.YTickLabel=yticklabels;

%%
%nuclear_percent_total_usa_text_4pt_timeline

%%
ax.XGrid='off';

tt=title(sprintf('Nuclear Fission\nPercent of Total U.S. Electricity'),'fontsize',30);
tt.Units='normalized';
tt.Position=[0.5 0.83 0];

%%


%k=sprintf("'Prior to 1975 the Atomic Energy Commission \nwas in charge of matters regarding radionuclides. \nThe AEC was dissolved, because it was perceived as\n unduly favoring the industry it was charged with regulating.'");
%text(0.62,0.14,k,'fontsize',18,'horizontalalignment','center','units','normalized')


text(0.6,-0.1,'Twitter: @peterdevietien   Data: EIA','fontsize',16,'units','normalized')
%%
print('~/projects/eia/post/nuclear_percent_total_usa','-dpng')
