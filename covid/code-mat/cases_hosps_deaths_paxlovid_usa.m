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
    plot_logistics=0;
    paxlovid_logistics_parameters

    %%
    f=L./(1+exp(-k.*(x-x0)));
    
    %%
    casescolor=[0.4940 0.1840 0.5560];
    
    %%
    yyaxis left
    %h(1)=plot(dates,hosps,'b-','linewidth',4);
    %ylabel('Patients in ICU')
    
    hold on
    h(1)=bar(dates(end-nscat:end),hosp_admins(end-nscat:end),'facecolor',hospcolor);
    h(2)=plot(dates,casesma/max(casesma)*max(hosp_admins(end-nscat:end)),'color',[0.4940 0.1840 0.5560],'linestyle','-','linewidth',2);
    hold off
    h(1).FaceAlpha=0.6;
    ytickformat('%,.0d')
    ax=gca;
    ax.YAxis(1).Exponent=0;


    y_lim=[0 30000];
    ylim(y_lim)
    %%
    %yyaxis right

    ax.YAxis(1).Color='k';
    ax.YAxis(2).Color='k';
    

    hold on
    h(3)=bar(t,f,'FaceColor',paxcolor);
    h(3).FaceAlpha=0.7;
    
    h(4)=plot(dates,deathsma*10,'color',ddcolor,'linewidth',4,'linestyle','-');

    plot([dates(end) dates(end)],[0 100000],'--','color',paxcolor,'linewidth',2)
    hold off
    
    
    %
    grid on
    ax=gca;
    ax.FontSize=16;

    yyaxis right
    ytickformat('%,.0d')
    ax.YAxis(2).Exponent=0;    
    ylim(y_lim)

  
    %%
    xlim([datetime(2021,11,15) datetime(2022,4,15)])

    %xdates=linspace(datetime(2021,10,1),dates(end),6);
    %ax.XTickLabel=datestr(xdates,'mmm dd');
    %ax.XTick=xdates;
    
    lgn=legend(h,'Daily Hospital Admissions','Daily Cases normalized','Daily Paxlovid Deliveries',['Deaths ',num2str(dma),' Day MA * 10'],'autoupdate','off');
    lgn.FontSize=15;
    lgn.Position=[0.1304 0.7009 0.3623 0.1845];
    
    y_lim=ylim;
    text(0.05,-0.1,'Twitter: @peterdevietien  Data: @OurWorldInData, U.S. Department HHS','fontsize',15,'units','normalized')
         
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
     hTxt(1,1)=text(datetime(2022,1,27),28000,{'Daily Deaths'},'FontSize',22,'color',ddcolor,'fontweight','bold');
     hTxt(2,1)=text(datetime(2022,2,4),15000,{sprintf('Paxlovid \nDeliveries')},'FontSize',20,'color',paxcolor,'fontweight','bold');
     hTxt(3,1)=text(datetime(2021,11,27),7000,{'Daily Hospitalizations'},'FontSize',24,'color',hospcolor,'fontweight','bold');
     hTxt(4,1)=text(datetime(2022,3,10),19200,{'Plateaus at 100k/day'},'FontSize',17,'rotation',65,'color',paxcolor);
    
    
    %
    printstr=sprintf('~/projects/covid/post/omicron/cases-hosps-deaths-paxlovid-%s',country);
    print(printstr,'-dpng','-r250')
end