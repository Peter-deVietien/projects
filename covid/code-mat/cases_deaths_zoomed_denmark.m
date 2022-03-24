cca
load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'Denmark'};
nc=numel(countries);
for i=1:nc
    cma=7;
    dma=7;
    nscat=75;
    sizescat=100;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    cases=t.new_cases(sel);
    deaths=t.new_deaths(sel);
    hosps=t.hosp_patients(sel);
    
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
    ylabel('Daily Cases','color','blue')
    
    hold on
    h(2)=bar(dates(end-nscat:end),cases(end-nscat:end),'facecolor','Blue');
    hold off
    
    h(2).FaceAlpha=0.3;
    
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;

    ylim([0 14000])
    %%
    yyaxis right
    set(gca,'YColor','red')

    hold on
    h(3)=plot(dates,deathsma,'r-','linewidth',4);
    hold off
    
    hold on
    h(4)=bar(dates(end-nscat:end),deaths(end-nscat:end),'FaceColor','red');
    hold off
    h(4).FaceAlpha=0.3;
    
    
    ylabel('Daily Deaths','color','red')

    ylim([0 20])
    %
    grid on
    ax=gca;
    ax.FontSize=16;


    

    
    %%
    set(gca, 'Children', flipud(get(gca, 'Children')) )

    %%
    xlim([datetime(2021,10,1) datetime])

    xdates=linspace(datetime(2021,10,1),dates(end),6);
    ax.XTickLabel=datestr(xdates,'mmm dd');
    ax.XTick=xdates;
    
    lgn=legend(h,['Cases ',num2str(cma),' Day MA'],'Cases That Day',['Deaths ',num2str(dma),' Day MA'],'Deaths That Day','autoupdate','off');
    lgn.FontSize=15;
    lgn.Position=[0.3132 0.6509 0.2973 0.1845];
    
    [cmin,cimin]=min(casesma(end-nscat:end));
    [dmin,dimin]=min(deathsma(end-nscat:end));
    cimin=numel(casesma)-nscat+cimin-1;
    dimin=numel(deathsma)-nscat+dimin-1;
    cases_percent=(casesma(end)/cmin-1)*100;
    deaths_percent=(deathsma(end)/dmin-1)*100;

    cases_prct_str=sprintf('%.0f,%.0f',floor(cases_percent/1000),cases_percent-floor(cases_percent/1000)*1000);
    deaths_prct_str=sprintf('%.0f',deaths_percent);
    
    text(dates(cimin)-12,69,sprintf('Cases up %s%%',cases_prct_str),'fontsize',17)
    text(dates(cimin)-12,76,sprintf('Deaths up %s%%',deaths_prct_str),'fontsize',17)
    text(datetime(2021,11,20),-12,'@peterdevietien','fontsize',17)
    
    hold on
    scatter(dates(dimin),deathsma(dimin),400,'x','linewidth',5,'markeredgecolor','black')
    hold off
    
    yyaxis left
    hold on
    scatter(dates(cimin),casesma(cimin),400,'x','linewidth',5,'markeredgecolor','black')
    hold off
    
    
    
%    t_str=sprintf('%s Cases and Deaths \nCases up %.0f%%',country,datestr(dates(end),'mmm dd, yyyy'),cases_prct_str);
    %t_str=sprintf('%s Cases and Deaths \nCases up %s%% since %s',country,cases_prct_str,datestr(dates(imin),'mmm dd'));
    t_str=sprintf('%s Cases and Deaths \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)

    %% Extra Adornments
    
    weeks=[dates(end-7):-7:dates(end-nscat)]+0.5;
    hold on
    for i=1:numel(weeks)
        plot([weeks(i) weeks(i)],[0 50000],'--','linewidth',0.2,'color',[0 0 0 0.1])
    end
    hold off
    
    fig=gcf;
    fig.Position=[476 400 583 466];
    
    %
    printstr=sprintf('~/projects/covid/post/omicron/cases-deaths-zoomed-%s',country);
    print(printstr,'-dpng','-r250')
end