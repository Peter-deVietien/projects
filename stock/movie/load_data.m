ls daif ~exist('ticker','var')
    ticker='TSLA';
end

mat_path=sprintf('~/Documents/Finance/code/%s_historical_prices.mat',ticker);
csv_path=sprintf('~/Documents/Finance/code/%s_historical_prices.csv',ticker);

refresh_data=false;

if exist(mat_path,'file')
    matdir=dir(mat_path);
    nownum=datenum(date);
    matnum=datenum(matdir.date(1:11));
    if nownum>matnum
        refresh_data=true;
    end
else
    refresh_data=true;
end

if refresh_data
    system(sprintf('/usr/local/bin/python3 ../retrieve_price_data.py %s',ticker));
    
    fid=fopen(csv_path,'r');

    data=textscan(fid,'%D %f %f %f %f %f %f %f','Delimiter',',','HeaderLines',1);
    fclose(fid);
    
    dates=datetime(data{1});
    
    open=data{2};
    high=data{3};
    low=data{4};
    close=data{5};
    volume=data{7};
    
    save(mat_path,'dates','open','high','low','close','volume');
else
    load(mat_path);
end