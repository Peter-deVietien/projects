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
    
%    Remove nans
    seln=isnan(excess_mort);
    excess_mort(seln)=[];
    emdates=dates;
    emdates(seln)=[];
    
    % Moving Averages
    deathsma=moving_average(dates,deaths,dma);
    deathsma=dspline(dates,deathsma,dates);
    deathsma=deathsma(55:end);
    dates=dates(55:end);
    
    %%
    
    h(1)=plot(emdates,excess_mort,'b-','linewidth',4);
    h(1).Color(4)=0.7;
    
    ylim([0 50])
    lylbl=ylabel('Percent Excess Mortality');
    lylbl.Position=[-90 25 -1];
    
    ax=gca;
    yticks=ax.YTick;
    ytlabel=[];
    for i=1:numel(yticks)
        ytlabel=[ytlabel {sprintf('%d%%',yticks(i))}];
    end
    
    ax.YTickLabel=ytlabel;
    
    yyaxis right
    h(2)=plot(dates,deathsma,'r-','linewidth',4);
    h(2).Color(4)=0.7;
    
    ylabel('Daily Deaths')
    
    %%
    ax=gca;
    ax.YAxis(1).Color='b';
    ax.YAxis(2).Color='r';
    ax.FontSize=20;

    grid on
    
    %%
    t_str=sprintf('%s Excess Mortality and Deaths \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
    fig=gcf;
    fig.Position=[476 212 1019 654];
    
    lgn=legend('Excess Mortality [%]','Normalized Daily Deaths');
    %lgn.Position=[0.2424 0.6735 0.1825 0.0742];
    
    x_lim=xlim;
    xlim([x_lim(1) x_lim(2)+days(20)])
    

    
    %% Extra Adornments
    text(0.6,-0.1,'Twitter: @peterdevietien  Data: OWID','fontsize',18,'units','normalized')
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/excess-mortality-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end