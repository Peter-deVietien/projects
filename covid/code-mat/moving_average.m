function [v_ma]=moving_average(dates,v_data,n_ma)

ndata=numel(v_data);
v_ma=nan(ndata,1);

last_date=dates(end);
ma_ind=find(dates>(last_date-n_ma),1,'first');
ind_span=numel(dates)-ma_ind;

for i=1:ndata
    ind=max(1,i-ind_span);
    v_ma(i)=mean(v_data(ind:i));
    %fprintf('v_data(i) = %.1f v_ma(i)=%.1f\n',v_data(i),v_ma(i));
end

