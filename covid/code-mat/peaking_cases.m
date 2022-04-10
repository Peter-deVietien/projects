cca
load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'South Africa','United Kingdom','United States','South Korea','France','New Zealand'};
nc=numel(countries);

fig=gcf;
fig.Position=[476 396 773 470];
lgs=[];

for i=1:nc
    cma=7;
    dma=7;

    % Select Country
    country=countries{i};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    cases=t.new_cases(sel);
        
    % Moving Averages
    casesma=moving_average(dates,cases,cma);
    casesma=dspline(dates,casesma,dates);
    
    %%
    
    dind=find(dates>datetime(2021,11,1),1,'first');
    
    dates=dates(dind:end);
    casesma=casesma(dind:end);
    
    
    %% Put max on day 80;
    [cmax,mind]=max(casesma);
    ndays=days(dates-dates(1))+80-mind;
    
    if strcmp(country,'South Korea')
        lw=2;
    else
        lw=0.7;
    end
    
    hold on
    plot(ndays,casesma/cmax,'linewidth',lw);
    hold off
    
    lgs=[lgs {country}];
    
    ylabel('Daily Cases')
    
    grid on
    ax=gca;
    ax.FontSize=16;

    xlim([20 120])
end

country='China';
sel=ismember(t.location,country);

dates=t.date(sel);
cases=t.new_cases(sel);

% Moving Averages
casesma=moving_average(dates,cases,cma);
casesma=dspline(dates,casesma,dates);

%% Put max on day 80;
[cmax,mind]=max(casesma);
ndays=days(dates-dates(1))+58-mind;

hold on
plot(ndays,casesma/cmax/3,'linewidth',4,'color','red');
hold off

lgs=[lgs {country}];


lgn=legend(lgs);
lgn.Position=[0.5427 0.1160 0.1889 0.2755];


ax.XTick=[3:7:120];
ax.XTickLabel=([3:7:120]-80)/7;
ax.YGrid='off';
ax.GridAlpha=0.25;

xlabel('Weeks')

text(0.6,-0.1,'Twitter: @peterdevietien  Data: OWID','fontsize',16,'units','normalized')


t_str=sprintf('Weeks Until Cases Peak');
title(t_str,'fontsize',24)

printstr=sprintf('~/projects/covid/post/omicron/cases_peaking',country);
print(printstr,'-dpng','-r250')