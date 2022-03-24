cca

%%
load_owid_data
set(0,'defaultlinelinestyle','-')

%
countries={'World'};
nc=numel(countries);
for i=1:nc
    figure
    cma=7;
    dma=7;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    cases=t.new_cases(sel);
    deaths=t.new_deaths(sel);
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    
    % Moving Averages
    casesma=moving_average(dates,cases,cma);
    deathsma=moving_average(dates,deaths,dma);

    %%
    yyaxis left
    
    set(gca,'YColor','Blue')
    
    h(1)=plot(dates,casesma,'b-','linewidth',4);
    h(1).Color(4)=0.6;
    
    ylabel('Daily Cases','color','blue')
    
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;
    
    y_lim=ylim;
    %ylim([0 y_lim(2)*1.05])

    %%
    yyaxis right
    
    set(gca,'YColor','red')

    hold on
    h(2)=plot(dates,deathsma,'r-','linewidth',4);
    h(2).Color(4)=0.6;
    
    plot([dates(1) dates(end)],[1 1]*deathsma(end),'r-','linewidth',0.5)
        hold off

    %% Load Paxlovid Data
    plot_logistics=0;
    paxlovid_logistics_parameters

    f=L./(1+exp(-k.*(x-x0)));
    
    hold on
    h(3)=plot(t,f,'g-','linewidth',4);
    h(3).Color(4)=0.7;
    
    bar(t,f,'g','facealpha',0.1)
    hold off
    
    
    ylim([0 20000])
    
    %%
        
    ylabel('Daily Deaths','color','red')

    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;
    ax.YAxis(2).Exponent=0;
    
    %
    grid on
    ax=gca;
    ax.FontSize=20;
    %ax.YTick=[0:1600:16000];
    
    %%
    t_str=sprintf('%s Cases and Deaths \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
    fig=gcf;
    fig.Position=[476 212 1019 654];
    
    lgn=legend(h,'7 Day Avg Cases LHS','7 Day Avg Deaths RHS','Daily Paxlovid Deliveries RHS');
    lgn.Position=[0.1300 0.8042 0.2738 0.1063];
    
    x_lim=xlim;
    xlim([x_lim(1) x_lim(2)+days(5)])
    
    %% Extra Adornments
    y_lim=ylim;
    text(0.45,-0.1,'Twitter: @peterdevietien    Data from @OurWorldInData','fontsize',18,'units','normalized')
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/cases-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end