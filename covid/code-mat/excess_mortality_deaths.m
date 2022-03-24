cca

%%
load_owid_data
set(0,'defaultlinelinestyle','-')

%
countries={'United States'};
nc=numel(countries);
for i=1:nc
    figure
    cma=7;
    dma=7;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    excess_mort=t.excess_mortality(sel);
    deaths=t.new_deaths(sel);
    
    % Remove nans
    seln=isnan(excess_mort);
    excess_mort(seln)=[];
    emdates=dates;
    emdates(seln)=[];
    
    % Moving Averages
    deathsma=moving_average(dates,deaths,dma);
    emdeaths=deathsma;
    emdeaths(seln)=[];
    emdeaths=emdeaths/max(emdeaths)*max(excess_mort);

    %%
    
    h(1)=plot(emdates,excess_mort,'b-','linewidth',4);
    h(1).Color(4)=0.7;
    
    
    hold on
    h(2)=plot(emdates,emdeaths,'r-','linewidth',4);
    h(2).Color(4)=0.7;
    hold off
    
    
    %
    grid on
    ax=gca;
    ax.FontSize=20;
    
    %%
    t_str=sprintf('%s Excess Mortality and Deaths \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
    fig=gcf;
    fig.Position=[476 212 1019 654];
    
    lgn=legend('Excess Mortality [%]','Normalized Daily Deaths');
    %lgn.Position=[0.2424 0.6735 0.1825 0.0742];
    
    x_lim=xlim;
    xlim([x_lim(1) x_lim(2)+days(20)])
    
    ylim([0 50])
    
    %% Extra Adornments
    y_lim=ylim;
    text(datetime(2020,8,1),-y_lim(2)/10,'Graphs from @peterdevietien','fontsize',15)
    text(datetime(2021,4,1),-y_lim(2)/10,'Data from @OurWorldInData','fontsize',15)
     
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/excess-mortality-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end