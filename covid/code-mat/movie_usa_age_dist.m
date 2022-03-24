cca
load_usa_age_data

frames_dir='post/movie-vaccines/frames';

cspop=[0; cumsum(pop_age)];

pp=spline([0; ages],cspop);
ppages=[0:1:100];
pppop=ppval(pp,ppages);

pop_bins=max(0,pppop(2:end)-pppop(1:end-1))/1000;

bar(ppages(2:end),pop_bins)

nbins=numel(pop_bins);

vaccines=0;
dv=0.1;
o_bins=pop_bins;
frame=1;
for i=nbins:-1:77
    while pop_bins(i)>0 & (i>76)
        if (pop_bins(i)-dv) >= 0
            pop_bins(i)=pop_bins(i)-dv;
        else
            remainder=dv-pop_bins(i);
            j=i;
            while remainder>0
                pop_bins(j)=0;
                j=j-1;
                remainder=dv-pop_bins(j);
            end
            i=j;
        end
           

        vaccines=vaccines+dv;
        
        red_bins=o_bins-pop_bins;
        
        bar(ppages(2:end),pop_bins,'black');
        hold on
        bar(ppages(2:end),red_bins,'green');
        hold off
        ax=gca;
        ax.FontSize=19;
        fig=gcf;
        fig.Position=[182 298 888 420];
        xlabel('Age')
        ylbl=ylabel('People per age [millions]');
        ylbl.Position(1)=-5;
        t_str=sprintf('US will distribute 20 million vaccines in December\nNumber vaccinated: %.0f million',vaccines);
        title(t_str)
        grid on
        ylim([0 6]);
        
        %%
        t_str=sprintf('Americans over 77 are 50%% of daily\nUS COVID deaths (CDC)');
        text(77,5,t_str,'fontsize',20,'horizontalalignment','center')
        
        t_str='@peterdevietien';
        text(10,5.5,t_str,'fontsize',18)
        
        hold on
        plot([1 1]*76,[0 4.5],'green','linewidth',5)
        hold off
        
        ar=annotation('arrow',[.71 .85],[.6 .6]);
        ar.Color='green';
        ar.LineWidth=4;
        
        
        %%
        frame_name=sprintf('%s/p%03d.png',frames_dir,frame);
        print(frame_name,'-dpng')
        frame=frame+1;      
        
    end
end
        