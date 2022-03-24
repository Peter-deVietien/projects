cca

ticker='TSLA';

load_data

MA_days=[50,200];

totaldays=numel(close);
nplot=250;

frame=1;
fig=figure;

for i=totaldays-nplot:totaldays
    tic
    %%
    idates=dates(totaldays-nplot:i);
    iclose=close(totaldays-nplot:i);
    [ax,h1,h2]=plotyy(idates,iclose,idates,iclose);
    %text(dates(i)+10,close(i),num2str(round(close(i),0)),'fontsize',20)

    %% Adornments
    ax(1).YColor=[0 0 0];
    ax(2).YColor=[0 0 0];
    ax(1).FontSize=20;
    ax(2).FontSize=20;
    h1.Color='m';
    h2.Color='m';
    h2.LineWidth=4;
    grid on
    t_str=sprintf('%s Stock Price: %s',ticker,datestr(dates(i)));
    title(t_str,'fontsize',20)
    ylabel('Stock Price')

    %ax=gca;
    %ax.FontSize=20;

    f=gcf;
    f.Position=[-1369 197 1337 479];
    
    
    
    %if frame<90
    %    ylim([160 280])
    if frame==1
        ind=max(totaldays-nplot-1,i-30);
    end
    if ~mod(i,3) & (frame>30)
        ind=max(totaldays-nplot-1,i-30);
    end
    
    ax(1).XTick=dates(ind:3:i);
    ax(2).XTick=dates(ind:3:i);
    
    ax(1).XLim=[dates(ind) dates(i)];
    ax(2).XLim=[dates(ind) dates(i)];
    
    ax(1).YLim=[min(close(i-30:i)) max(close(i-30:i))];
    ax(2).YLim=[min(close(i-30:i)) max(close(i-30:i))];
    
    %ax(1).XGrid='off';
    %ax(2).XGrid='off';
    %end

    %%
    save_name=sprintf('movie_sp/frames/TSLA_SP_%d.png',frame);
    print(save_name,'-dpng')
    frame=frame+1;
    toc
end