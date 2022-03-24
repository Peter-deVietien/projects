cca

load_data

trailing_days=80;


%%
plot(dates,high,'k','linewidth',1)
hold on
plot(dates,low,'k','linewidth',1)
hold off


%% txd low

np=numel(low);
for i=1:np
    ind1=max(1,i-trailing_days);
    txdl(i)=min(low(ind1:i));
end

hold on
plot(dates,txdl,'g','linewidth',2)
hold off

%% txd high

np=numel(high);
for i=1:np
    ind1=max(1,i-trailing_days);
    txdh(i)=max(high(ind1:i));
end

hold on
plot(dates,txdh,'r','linewidth',2)
hold off


%%

%$175: ?Stock price that we have is more than we have any right to deserve? ?? Elon Musk, 10/24/2013
%$290: ?I think our stock price is kinda high right now? ?? Elon Musk, 9/4/2014
%$330: ?Stock price is higher than we have the right to deserve? ?? Elon Musk, 7/15/2017
%and:
%"Whoa ? the stock is so high lol" @420 ?? Elon Musk, 12/23/2019

d1=datetime('10/24/2013');
hold on
plot([d1 d1],[0 max(high)],'k--')
hold off

d1=datetime('9/4/2014','format','MM/dd/uuuu');
hold on
plot([d1 d1],[0 max(high)],'k--')
hold off

d1=datetime('7/15/2017','format','MM/dd/uuuu');
hold on
plot([d1 d1],[0 max(high)],'k--')
hold off

d1=datetime('5/1/2020','format','MM/dd/uuuu');
hold on
plot([d1 d1],[0 max(high)],'k--') 
hold off

%% Adornments

grid on
t_str=sprintf('Tesla Stock Price\nTrailing %d day maximum and minimum',trailing_days);
title(t_str,'fontsize',20)
ylabel('Stock Price')

ax=gca;
ax.FontSize=20;

f=gcf;
f.Position=[-1744 314 1688 464];