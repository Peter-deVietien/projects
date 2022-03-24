cca

%%
load_owid_data
set(0,'defaultlinelinestyle','-')

%
countries={'United Kingdom','United States','France','Italy','Spain','Israel','Belgium','Canada','Denmark'};
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

    % Normalize
    casesma=casesma/max(casesma(1:420));
    deathsma=deathsma/max(deathsma(1:420));
    hosps=hosps/max(hosps(1:420));
    
    %%
    fig=gcf;
    fig.Position=[-1081 149 1019 638];
            
    h(1)=plot(dates,casesma,'b-','linewidth',4);
    
    hold on
    h(2)=plot(dates-hshift,hosps,'g-','linewidth',4);
    h(3)=plot(dates-dshift,deathsma,'r-','linewidth',4);
    hold off
    
    h(1).Color=[0 0 1 0.5];
    h(2).Color=[0 1 0 0.5];
    h(3).Color=[1 0 0 0.5];
    
    %
    grid on
    ax=gca;
    ax.FontSize=20;

    y_lim=ylim;
    ylim([0 y_lim(2)])
    
    %%
    t_str=sprintf('%s \nHospitalizations Shifted Back One Week\nDeaths Shifted Back Two Weeks\nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
%     fig=gcf;
%     fig.Position=[476 212 1019 654];
    
    lgn=legend('Cases','Hospitalizations','Deaths');
    %lgn.Position=[0.2699 0.6766 0.1825 0.0742];
    lgn.Location='best';
    %% Extra Adornments
    
    y_lim=ylim;
    text(datetime(2021,1,1),-y_lim(2)/10,'Graphs from @peterdevietien','fontsize',15)
    text(datetime(2021,8,1),-y_lim(2)/10,'Data from @OurWorldInData','fontsize',15)
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/cases-hosps-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end