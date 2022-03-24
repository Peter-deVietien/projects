clear
close all

load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'United Kingdom','United States','France','Israel','South Africa','World','Europe','South America'};
nc=numel(countries);
for i=1:nc
    figure
    country=countries{i}
    dma=7;
    death_scale=1;
    sel=ismember(t.location,country);

    dates=t.date(sel);
    
    seln=isnan(t.new_cases_per_million);
    t.new_cases_per_million(seln)=0;
    cases=moving_average(dates,t.new_cases_per_million(sel),dma);
    hosps=moving_average(dates,t.hosp_patients_per_million(sel),dma);
    deaths=moving_average(dates,t.new_deaths_per_million(sel),dma)*death_scale;

    %

    plot(dates,cases,'b-','linewidth',3)
    hold on
    plot(dates,hosps,'g-','linewidth',3)
    hold off
    ylabel('Cases, Hospitalized Per Million','color','blue')

    y_lim=ylim;
    y_lim(1)=0;
    ylim([y_lim])

    yyaxis right
    ax=gca;
    ax.YColor='r';

    hold on
    plot(dates,deaths,'r-','linewidth',3)
    hold off
    ylabel('Deaths per Million','color','red')

    y_lim=ylim;
    y_lim(1)=0;
    ylim([y_lim])

    %
    grid on
    ax=gca;
    ax.FontSize=16;

    fig=gcf;
    fig.Position=[440 356 689 441];

    lgn=legend('Cases (LHS)','Hospitalized (LHS)',sprintf('Deaths (RHS)',death_scale),'autoupdate','off');
    lgn.FontSize=15;
    lgn.Position=[0.2080 0.7625 0.2554 0.1202];

    monthday=datestr(dates(end),'mmm dd');
    if monthday(5)=='0'
        monthday(5)=[];
    end
    t_str=sprintf('%s COVID as of %sth, %s',country,monthday,datestr(dates(end),'yyyy'));
    title(t_str)

    %
    if 0
        cind=find(cases>=cases(end),1,'first');

        hold on
        plot([dates(cind) dates(end)],[deaths(cind) deaths(cind)],'r--');
        scatter(dates(cind),deaths(cind),70,'red','filled')
        scatter(dates(end),deaths(cind),70,'red','filled')
        hold off

        yyaxis left

        hold on
        plot([dates(cind) dates(end)],[cases(end) cases(end)],'b--');
        scatter(dates(cind),cases(end),70,'blue','filled')
        scatter(dates(end),cases(end),70,'blue','filled')
        hold off
    end
    %
    fig=gcf;
    fig.Position(3)=fig.Position(3)*1.5;
    fig.Position(4)=fig.Position(4)*1.5;
    printstr=sprintf('~/projects/covid/post/%s-case-hosp-death-per-mil',country);
    print(printstr,'-dpng')
end