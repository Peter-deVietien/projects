cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%%

lp=log(price/price(1));


%% Plot least squares
dls = [];
for i=1:numel(dates)
    dls(i)=days(dates(i)-dates(1));
end

[yo,mo,x,bo]=least_squares(dls,lp);

%% Extrapolate a bit

ppx=[x;[x(end):(x(end)+365*5)]'];
pp=polyfit(x,yo,1);
ppy=polyval(pp,ppx);

ppx(1:numel(x))=[];
ppy(1:numel(x))=[];

%%
fps=20;
h=figure;
%plot(dates(1)+x,exp(yo)*price(1),'linewidth',4)

loops=numel(dates);
ax=gca;
ax.NextPlot='replaceChildren';
axis tight manual
F(loops) = struct('cdata',[],'colormap',[]);
%h.Visible='off';

v=VideoWriter(sprintf('../post/sp500_fortuna_%d.mp4',fps),'MPEG-4');
v.FrameRate=25;
open(v);

grid on
ax.FontSize=18;

trendcolor=[207 181 59]/256;

dyticks=[2,5,10,20,50,100,200,500];
dyind=1;
dyarray=[0];

for i=1:15:numel(dates)


    plot(dates(1:i),price(1:i),'b','linewidth',3)

    hold on
    grid on
    ax=gca;
    ax.FontSize=28;
    ax.GridAlpha=0.6;
    title('S&P 500 and 70 Year Trend','fontsize',35)
    
    plot(dates(1)+x,exp(yo)*price(1),'linewidth',5,'color',trendcolor)
    %plot(dates(1)+ppx,exp(ppy)*price(1),'linewidth',4,'linestyle','--','color',trendcolor)
    hold off
    
    xlimi=max(1,i-3300);
    xlim([dates(xlimi) dates(i)+calyears(1)]);
   
    minyear=dates(xlimi).Year;
    xticks=[datetime(minyear,1,1):calyears(1):datetime(minyear+15,1,1)];
    ax.XTick=xticks;
    ax.XTickLabel=datestr(xticks,'yyyy');
    
    ylim([exp(yo(i))*price(1)*0.3    exp(yo(i))*price(1)*2.05])

    ax=gca;
    yticks=ax.YTick;
    dy=yticks(2)-yticks(1);
    
    if dy>dyarray(end)
        dyarray=[dyarray dy];
    end
    

    nyticks=[0:dyarray(end):8000];
    ax.YTick=nyticks;
    
    ylim([exp(yo(i))*price(1)*0.3    exp(yo(i))*price(1)*2.05])

    
    fig=gcf;
    fig.Position=[64 389 1280 720];
    
    xtxt=0.05;
    ytxt=-0.1;
    txt=text(xtxt,ytxt,'Twitter: @peterdevietien','fontsize',18,'units','normalized');
    txt.Position(1)=-0.15;
    

    F=getframe(gcf);
    writeVideo(v,F);
    
    if (i+15)>=numel(dates)
        for k=1:200
            F=getframe(gcf);
            writeVideo(v,F);
        end
    end
end

close(v);
%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on
%ylabel('')

lgn=legend('S&P 500','70 Year Least Squares Fit','Extrapolation');
lgn.Position=[0.6993 0.1985 0.1520 0.1240];

title('S&P 500 and 70 Year Least Squares Fit')

ylbl=ylabel('S&P 500 Price');
ylbl.Position(1)=1.3806e+04;


ax=gca;
ax.FontSize=18;

%%
ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;
y_lim=ylim;
yyaxis right
ax.YAxis(2).Color='k';
ax=gca;
ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;
ylim(y_lim);

%%

fig=gcf;
fig.Position=[23 367 1500 500];

%xlim([datetime(1990,1,1) datetime(2029,1,1)])



%%
print('~/projects/stock/post/sp500_least_squares_linear','-dpng')