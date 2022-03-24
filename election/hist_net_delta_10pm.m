cca
load_data

t_delta=2;
spread=65;
ind=1;
ct=1;
net_delta=net_delta/1000;
ind0=ind;
ind1=ind+t_delta+spread;
v = VideoWriter('post/movie-hist/hist_net_delta','Motion JPEG AVI');
v.FrameRate=7;
open(v);

while ind1<numel(net_delta)

    plot_delta=net_delta(ind:ind1);

    nbins=100;
    bin_edges=-20:0.5:20;
    histogram(plot_delta,bin_edges)

    %%
    %xticks=[-36:3:36];
    grid on
    ylim([0 15])
    xlim([-20 20])

    ax=gca;
    ax.FontSize=20;

    fig=gcf;
    fig.Position=[18 304 1414 396];

    t0=times(ind0);
    time0=sprintf('%02d:%02d',t0.Hour,t0.Minute);

    t1=times(ind1);
    time1=sprintf('%02d:%02d',t1.Hour,t1.Minute);
    
    t_str=sprintf('Histogram of change of Pennsylania votes (Trump - Biden) \nVote chunks one hour after: Nov %dth %s UTC',t0.Day,time0);
    title(t_str);
    
    text(-15,12,'@peterdevietien','fontsize',17)
    
    xlabel('Net change votes [thousands]')
    ylabel('Number of instances per bin')
    
    drawnow
    %pause(0.2)
    ind=ind+t_delta;
%     p_str=sprintf('post/movie-hist/frames/p%04d.png',ct);
%     print(p_str,'-dpng')
%     
    F=getframe(gcf);
    writeVideo(v,F);
    
    ind0=ind;
    ind1=ind+t_delta+spread;
    

end

close(v)