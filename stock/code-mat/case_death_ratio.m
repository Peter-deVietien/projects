clear
close all

load_owid_data

%
countries={'South Africa','World','United States','United Kingdom','Denmark'};
nc=numel(countries);
lgs=[];

for ic=1:nc
    cma=7;
    dma=14;
    
    % Select Country
    country=countries{ic};
    sel=ismember(t.location,country);
    
    dates=t.date(sel);
    cases=t.new_cases(sel);
    deaths=t.new_deaths(sel);
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    deaths(seln)=0;
    
    % Moving Averages
    casesma=moving_average(dates,cases,cma);
    deathsma=moving_average(dates,deaths,dma);

    %%
    if ic>1
        hold on
    end
    
    h(ic)=plot(dates,casesma./deathsma,'linewidth',4);
    hold off

    lgs=[lgs {country}];
    
    
end

ylabel('Cases Per Death')

%%
grid on
ax=gca;
ax.FontSize=16;

t_str=sprintf('Cases per Death \nIncludes %s',datestr(dates(end),'mmm dd'));
title(t_str)

lgn=legend(h,lgs,'autoupdate','off');
lgn.FontSize=15;
lgn.Position=[0.3661 0.3833 0.2679 0.1845];

fig=gcf;
%fig.Position=[476 400 583 466];

%
printstr=sprintf('~/projects/covid/post/case-death-ratio',country);
print(printstr,'-dpng')
