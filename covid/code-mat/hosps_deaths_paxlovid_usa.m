cca
load_owid_data
set(0,'defaultlinelinestyle','-')


%
countries={'United States'};
nc=numel(countries);
for i=1:nc
    
    ddcolor=[0.6350 0.0780 0.1840];
    paxcolor=[0.4660 0.6740 0.1880];
    hospcolor=[0 0.4470 0.7410];
    
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
    paxlovid_logistics_parameters

    %%
    f=L./(1+exp(-k.*(x-x0)));
    
    %%
    %plot(
    
    %%
    yyaxis left
    %h(1)=plot(dates,hosps,'b-','linewidth',4);
    %ylabel('Patients in ICU')
    
    hold on
    h(1)=bar(dates(end-nscat:end),hosp_admins(end-nscat:end),'facecolor',hospcolor);
    hold off
    h(1).FaceAlpha=0.5;
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;


    
    ylim([0 50000])
    %%
    %yyaxis right

    ax.YAxis(1).Color='k';
    ax.YAxis(2).Color='k';
    

    hold on
    h(2)=bar(t,f,'FaceColor',paxcolor);
    hold off
    h(2).FaceAlpha=0.7;
    
    hold on
    h(3)=plot(dates,deathsma,'color',ddcolor,'linewidth',4,'linestyle','-');
    hold off
    
    
    %
    grid on
    ax=gca;
    ax.FontSize=16;

    yyaxis right
    ytickformat('%,.0d')
    ax.YAxis(2).Exponent=0;    
    ylim([0 50000])

  
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
    
     hTxtx=datetime(2021,10,25);
     hTxt(1,1)=text(datetime(2022,2,1),4200,{'Daily Deaths'},'FontSize',22,'color',ddcolor,'fontweight','bold');
     hTxt(2,1)=text(datetime(2022,2,10),24500,{sprintf('Paxlovid \nDeliveries')},'FontSize',20,'color',paxcolor,'fontweight','bold');
     hTxt(3,1)=text(datetime(2021,12,1),11000,{'Daily Hospitalizations'},'FontSize',20,'color',hospcolor,'fontweight','bold');
     hTxt(4,1)=text(datetime(2022,3,17),33000,{'Plateaus at 100k/day'},'FontSize',17,'rotation',70,'color',paxcolor);
    
    
    %
    printstr=sprintf('~/projects/covid/post/omicron/hosps-deaths-paxlovid-%s',country);
    print(printstr,'-dpng','-r250')
end