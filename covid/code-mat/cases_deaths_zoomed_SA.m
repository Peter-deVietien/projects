cca
load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'South Africa'};
nc=numel(countries);
for i=1:nc
    cma=7;
    dma=7;
    nscat=150;
    sizescat=100;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    cases=t.new_cases(sel);
    deaths=t.new_deaths(sel);
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    seln=find(isnan(deaths));
    deaths(seln)=0;
        
%     % Remove spike
%     k=find(deaths==-257);
%     deaths(k-3:k)=mean(deaths(k-3:k));
    
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

    ylim([0 30000])
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

    ylim([0 500])
    %
    grid on
    ax=gca;
    ax.FontSize=16;

    
    %%
    set(gca, 'Children', flipud(get(gca, 'Children')) )

    %%
    xlim([datetime(2021,11,1) datetime])

    xdates=linspace(datetime(2021,10,1),dates(end),6);
    ax.XTickLabel=datestr(xdates,'mmm dd');
    ax.XTick=xdates;
    
    lgn=legend(h,['Cases ',num2str(cma),' Day MA'],'Cases That Day',['Deaths ',num2str(dma),' Day MA'],'Deaths That Day','autoupdate','off');
    lgn.FontSize=15;
    lgn.Position=[0.2632 0.6509 0.2973 0.1845];
    
    y_lim=ylim;
    text(datetime(2021,10,24),-y_lim(2)/10,'@peterdevietien','fontsize',15)
    text(datetime(2021,12,1),-y_lim(2)/10,'Data from @OurWorldInData','fontsize',15)
         
    t_str=sprintf('%s Cases and Deaths \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)

    %% Extra Adornments
    
    weeks=[dates(end-7):-7:dates(end-nscat)]+0.5;
    hold on
    for i=1:numel(weeks)
        plot([weeks(i) weeks(i)],[0 50000],'--','linewidth',0.3,'color',[0 0 0 0.4])
    end
    hold off
    
    fig=gcf;
    fig.Position=[476 400 583 466];
    
    %
    printstr=sprintf('~/projects/covid/post/omicron/cases-deaths-zoomed-%s',country);
    print(printstr,'-dpng','-r250')
end