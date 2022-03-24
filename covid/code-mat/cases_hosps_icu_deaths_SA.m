cca

%%
load_owid_data
set(0,'defaultlinelinestyle','-')

%
countries={'South Africa'};
nc=numel(countries);
for i=1:nc
    figure
    cma=7;
    dma=7;
    hshift=0;
    dshift=0;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    odates=t.date(sel);
    cases=t.new_cases(sel);
    deaths=t.new_deaths(sel);
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    seln=find(isnan(deaths));
    
        deaths(seln(end-1))=mean(deaths(seln(end-1)-1),deaths(seln(end-1)+1));
        deaths(seln(end))=deaths(seln(end)-1);
    
    % Moving Averages
    casesma=moving_average(odates,cases,cma);
    deathsma=moving_average(odates,deaths,dma);
    
    %% Load NICD data
    load_nicd_SA
    
    %%
    hosps=hosp(:,3);
    icu=hosp(:,4);
    
    %%
    fig=gcf;
    fig.Position=[-1081 149 1019 638];
            
    yyaxis left
    hl(1)=plot(odates,casesma,'b-','linewidth',4);
    
    hold on
    hl(2)=plot(dates-hshift,hosps,'g-','linewidth',4);
    hold off
    
    hl(1).Color=[0 0 1 0.5];
    hl(2).Color=[0 1 0 0.5];
    
    ylabel('Cases and Hospitalized')
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;
    
    yyaxis right
    hr(1)=plot(dates-hshift,icu,'m-','linewidth',4);
    hold on
    hr(2)=plot(odates-dshift,deathsma*10,'r-','linewidth',4);
    hold off
        
    ytickformat('%,.0d')
    ylabel('ICU and (Deaths*10)')
    
    hr(1).Color=[1 0 1 0.5];
    hr(2).Color=[1 0 0 0.5];
    
    %
    grid on
    ax=gca;
    ax.FontSize=20;
    
    ylim([0 4200])
    
    xlim([datetime(2021,4,15) datetime])
    
    %%
    t_str=sprintf('%s \nCases, Hospitalized, ICU and Deaths\nIncludes %s',country,datestr(odates(end),'mmm dd'));
    title(t_str)
    
%     fig=gcf;
%     fig.Position=[476 212 1019 654];
    
    lgn=legend('Cases (LHS)','Hospitalized (LHS)','ICU (RHS)','Daily Deaths*10 (RHS)');
    %lgn.Location='best';
    lgn.Position=[0.5788 0.6319 0.2159 0.1434];
    
    %% Extra Adornments
    y_lim=ylim;
    text(datetime(2021,6,1),-y_lim(2)/10,'Graphs from @peterdevietien','fontsize',15)
    text(datetime(2021,9,1),-y_lim(2)/10,'Data from @OurWorldInData and @nicd\_sa','fontsize',15)
    
    %% Overlay image
    
    [a,map,alpha]=imread('/Users/peter/Desktop/tankhead.jpeg');
    %ax2=axes('Parent',fig)
    %I=imshow(a);
    
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/cases-hosps-icu-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end