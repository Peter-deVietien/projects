cca

%%
load_owid_data
set(0,'defaultlinelinestyle','-')

%
countries={'United Kingdom'};
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
    icu=t.icu_patients(sel);
    
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    
    % Moving Averages
    casesma=moving_average(dates,cases,cma);
    deathsma=moving_average(dates,deaths,dma);
    
    %%
    yyaxis left
    fig=gcf;
    fig.Position=[-1081 149 1019 638];
            
    hl(1)=plot(dates,casesma,'b-','linewidth',4);
    
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
    hr(1)=plot(dates,icu,'m-','linewidth',4);
    hold on
    hr(2)=plot(dates-dshift,deathsma*5,'r-','linewidth',4);
    hold off
    

    hr(1).Color=[1 0 1 0.5];
    hr(2).Color=[1 0 0 0.5];
    
    ylabel('ICU and (Deaths*5)')
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;
    
    %
    grid on
    ax=gca;
    ax.FontSize=20;

    y_lim=ylim;
    ylim([0 y_lim(2)])
    
    x_lim=xlim;
    xlim([x_lim(1) x_lim(2)+days(10)])
    
    %%
%    t_str=sprintf('%s \nHospitalizations Shifted Back One Week\nDeaths Shifted Back Two Weeks\nIncludes %s',country,datestr(dates(end),'mmm dd'));
    t_str=sprintf('%s \nCases, Hospitalizations, ICU and Deaths\nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
%     fig=gcf;
%     fig.Position=[476 212 1019 654];
    
    lgn=legend('Cases (LHS)','Hospitalizations (LHS)','ICU (RHS)','Deaths*5 (RHS)');
    %lgn.Position=[0.2699 0.6766 0.1825 0.0742];
    lgn.Location='best';
    
    %% Extra Adornments
    
    y_lim=ylim;
    text(datetime(2021,1,1),-y_lim(2)/10,'Graphs from @peterdevietien','fontsize',15)
    text(datetime(2021,8,1),-y_lim(2)/10,'Data from @OurWorldInData','fontsize',15)
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/cases-hosps-icu-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end