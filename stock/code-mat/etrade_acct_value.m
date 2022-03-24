cca;
t=readtable('data/etrade_acct_mar_2021.xlsx');

dates=datetime(t.Date);
dates=dateshift(dates,'start','month');
value=t.Value;



for i=1:numel(value)
    bar(dates(1:i),value(1:i))
    ax=gca;
    ax.FontSize=15;
    ytickformat('usd')
    xtickformat('MMM-yy')
    xtickangle(0)
    grid on
    fig=gcf;
    fig.Position=[440   260   899   537];
    if i<8
        xlim([dates(1)-days(15) dates(8)])
    else
        xlim([dates(i-7)-days(15) dates(i)+days(15)])
    end
    drawnow
    if i==3
        pause(10)
    else
        pause(2.2)
    end
end