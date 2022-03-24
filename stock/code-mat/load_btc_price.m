


if ~exist('~/projects/stock/data/btc_price.mat','file')

    t=readtable('~/Downloads/bitstampUSD_1-min_data_2012-01-01_to_2021-03-31.csv');

    time=datetime(t.Timestamp,'ConvertFrom','epochtime');
    price=t.Weighted_Price;
    

    k=isnan(price);
    time(k)=[];
    price(k)=[];

    time=time(1:10:end);
    price=price(1:10:end);
    
    
    save('~/projects/stock/data/btc_price.mat','time','price')
    
else
    load('~/projects/stock/data/btc_price.mat')

end