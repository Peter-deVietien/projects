cca
load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'United States'};
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
    hosp_admins=t.weekly_hosp_admissions(sel)/7;
    
    
    % Remove nans
    seln=isnan(cases);
    cases(seln)=0;
    
    % Moving Averages
    casesma=moving_average(dates,cases,cma);
    deathsma=moving_average(dates,deaths,dma);

    %% Load Paxlovid Data
    %%
    L=100*1000;
    x0=85;
    k=.04;
    x=[-30:270];
    t0=datetime(2022,1,1);
    t=t0+x;

    %%
    f=L./(1+exp(-k.*(x-x0)));
    
    %%
    yyaxis left
    %h(1)=plot(dates,hosps,'b-','linewidth',4);
    %ylabel('Patients in ICU')
    
    hold on
    h(1)=bar(dates(end-nscat:end),hosp_admins(end-nscat:end),'facecolor','Blue');
    hold off
    h(1).FaceAlpha=0.3;
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;

     hTxtx=datetime(2021,10,25);
     hTxt(1,1)=text(hTxtx,1000,{'Daily Deaths'},'Rotation',90,'FontSize',20,'color','g','fontweight','bold');
     hTxt(2,1)=text(hTxtx,65000,{'Paxlovid'},'Rotation',90,'FontSize',20,'color','m','fontweight','bold');
     hTxt(3,1)=text(hTxtx,25000,{'Daily Hospitalizations'},'Rotation',90,'FontSize',20,'color','b','fontweight','bold');
    
    
    ylim([0 50000])
    %%
    %yyaxis right

    ax.YAxis(1).Color='k';
    ax.YAxis(2).Color='k';
    

    
    hold on
    h(2)=bar(t,f,'FaceColor','magenta');
    hold off
    h(2).FaceAlpha=0.7;
    
    hold on
    h(3)=plot(dates,deathsma,'g-','linewidth',4);
    hold off
    
    
    %
    grid on
    ax=gca;
    ax.FontSize=16;

    yyaxis right
    ytickformat('%,.0d')

    
    %%
    t=readtable('~/Downloads/North_America_Petroleum_Consumption.csv');
    
    ny=numel(t.Year);
    tyear=[];
    
    for i=1:ny
        tyear = [tyear {t.Year(i)}]
    end
    
    
    tcons=t.NorthAmericaPetroleumConsumptionMillionBarrelsPerDay;
    
    
    
    hold on
    plot(tyear,tcons)
    hold off
  
    %%
    xlim([datetime(2021,11,15) datetime(2022,4,15)])

    %xdates=linspace(datetime(2021,10,1),dates(end),6);
    %ax.XTickLabel=datestr(xdates,'mmm dd');
    %ax.XTick=xdates;
    
    lgn=legend(h,'Daily Hospital Admissions','Daily Paxlovid Deliveries',['Deaths ',num2str(dma),' Day MA'],'autoupdate','off');
    lgn.FontSize=15;
    lgn.Position=[0.2632 0.6509 0.2973 0.1845];
    
    y_lim=ylim;
    text(datetime(2021,11,19),-y_lim(2)/10,'@peterdevietien','fontsize',15)
    text(datetime(2022,1,1),-y_lim(2)/10,'Data from @OurWorldInData, U.S. Department HHS','fontsize',15)
         
    t_str=sprintf('%s \nDaily Hospitalizations, Deaths and Paxlovid Deliveries \nIncludes %s',country,datestr(dates(end),'mmm dd'));
    title(t_str)

    %% Extra Adornments
    
%     weeks=[dates(end-7):-7:dates(end-nscat)]+0.5;
%     hold on
%     for i=1:numel(weeks)
%         plot([weeks(i) weeks(i)],[0 50000],'--','linewidth',0.3,'color',[0 0 0 0.4])
%     end
%     hold off
    
    fig=gcf;
    fig.Position=[391 266 668 600];
    
    %
    printstr=sprintf('~/projects/covid/post/omicron/hosps-deaths-paxlovid-%s',country);
    print(printstr,'-dpng','-r250')
end