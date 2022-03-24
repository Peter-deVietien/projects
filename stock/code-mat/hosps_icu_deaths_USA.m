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
    hshift=0;
    dshift=0;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    deaths=t.new_deaths(sel);
    hosps=t.hosp_patients(sel);
    icu=t.icu_patients(sel);
    
    
    % Moving Averages
    deathsma=moving_average(dates,deaths,dma);

    %%
    fig=gcf;
    fig.Position=[-1081 149 1019 638];
            
    h(1)=bar(dates,hosps,'b');
    h(1).FaceAlpha=0.5;
    
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;
    
    ylabel('Hospitalized Patients')
    
    yyaxis right

    
    
    h(2)=plot(dates,icu,'m-','linewidth',4);
    hold on
    h(3)=plot(dates,deathsma,'r-','linewidth',4);
    hold off

        ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(2).Exponent=0;
    ylabel('ICU Patients and Deaths')

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
    t_str=sprintf('%s \nHospitalized, ICU and Deaths\nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)
    
%     fig=gcf;
%     fig.Position=[476 212 1019 654];
    
    lgn=legend('Hospitalized (LHS)','ICU (RHS)','Deaths (RHS)');
    lgn.Position=[0.4779 0.6782 0.1658 0.1089];
    %lgn.Location='best';
    
    xlim([datetime(2021,6,1),datetime(2022,4,1)])
    
    %% Extra Adornments
    
    y_lim=ylim;
    text(datetime(2021,1,1),-y_lim(2)/10,'Graphs from @peterdevietien','fontsize',15)
    text(datetime(2021,8,1),-y_lim(2)/10,'Data from @OurWorldInData','fontsize',15)
    
    %%
    printstr=sprintf('~/projects/covid/post/omicron/hosps-icu-deaths-%s',country);
    print(printstr,'-dpng','-r350')
end