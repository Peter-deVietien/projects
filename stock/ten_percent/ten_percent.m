cca

ticker='TSLA';

load_data

balance(1)=100e3;
target_percent=10;
delta_percent=5;
shares(1)=floor(balance(1)/price(1)*(target_percent/100));
cash(1)=balance(1)-price(1)*shares(1);
percent(1)=shares(1)*price(1)/balance(1);

%%
% figure(1)
% plot(dates_full(1:50),price(1:50),'k','linewidth',2)
% lgn='Stock Price';
% 
% fig=gcf;
% fig.Position=[36 329 560 420];
% 
% figure(2)
% fig=gcf;
% fig.Position=[541 327 560 420];
fprintf('      balance   percent  shares   cash\n')

for i=2:numel(price)
    shares(i)=shares(i-1);
    cash(i)=cash(i-1);
    balance(i)=cash(i)+shares(i)*price(i);
    percent(i)=shares(i)*price(i)/balance(i);
    
    %fprintf('pre:  %.1f    %.1f     %d   %.1f\n',balance(i),percent(i)*100,shares(i),cash(i))

    if percent(i) > (target_percent + delta_percent)/100 % Sell shares
        shares(i)=floor(balance(i)/price(i)*(target_percent/100));
        cash(i)=cash(i)+(shares(i-1)-shares(i))*price(i);
        fprintf('sell\n')
    elseif percent(i) < (target_percent - delta_percent)/100 % Buy shares
        shares(i)=floor(balance(i)/price(i)*(target_percent/100));
        cash(i)=cash(i)+(shares(i-1)-shares(i))*price(i);
        fprintf('buy\n')
    end
    percent(i)=shares(i)*price(i)/balance(i);
    balance(i)=cash(i)+shares(i)*price(i);
    
    %fprintf('post: %.1f    %.1f     %d   %.1f\n',balance(i),percent(i)*100,shares(i),cash(i))

end

figure
plot(dates_full,balance)
hold on
plot(dates_full,price/price(1)*balance(1))
hold off

legend('balance','price')

figure
plot(dates_full,percent)


%% Adornments

% grid on
% t_str=sprintf('%s Stock Price',ticker);
% title(t_str,'fontsize',20)
% ylabel('Stock Price')
% 
% ax=gca;
% ax.FontSize=26;
% 
% f=gcf;
% f.Position=[-1744 314 1688 464];
% 
% lgh=legend(lgn,'location','best','autoupdate','off');
% 
% %%
% save_name=sprintf('%s_moving_average.png',ticker);
% print(save_name,'-dpng')