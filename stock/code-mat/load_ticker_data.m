function d = load_ticker_data(ticker)

d.mat_path=sprintf('~/projects/stock/data/%s_historical_prices.mat',ticker);
d.csv_path=sprintf('~/projects/stock/data/%s_historical_prices.csv',ticker);

if ispc
    d.mat_path=sprintf('C:/Users/pdevi/Desktop/projects/stock/data/%s_historical_prices.mat',ticker);
    d.csv_path=sprintf('C:/Users/pdevi/Desktop/projects/stock/data/%s_historical_prices.csv',ticker);
end

d.refresh_data=false;

if exist(d.mat_path,'file')
    d.matdir=dir(d.mat_path);
    
    d.nownum=datenum(date);
    d.matnum=datenum(d.matdir.date(1:11));
    if d.nownum>d.matnum
        d.refresh_data=true;
    end
else
    d.refresh_data=true;
end

if d.refresh_data
    
    if ispc
        pythonpath="%ProgramFiles%/WindowsApps/PythonSoftwareFoundation.Python.3.10_3.10.1264.0_x64__qbz5n2kfra8p0/python3.10.exe";
        str=sprintf('"%s" C:/Users/pdevi/Desktop/projects/stock/code-py/retrieve_price_data.py %s',pythonpath,ticker);
        system(str)
    else
        system(sprintf('/Users/peter/opt/anaconda3/bin/python3 ~/projects/stock/code-py/retrieve_price_data.py %s',ticker));

    end

    fid=fopen(d.csv_path,'r');

    data=textscan(fid,'%D %f %f %f %f %f %f %f','Delimiter',',','HeaderLines',1);
    fclose(fid);
    
    d.dates=datetime(data{1});
    d.dates.Format='uuuu-MMM-dd';
    d.dates_open=d.dates + hours(1);
    d.dates_mid=datetime(data{1}) + hours(12);
    d.dates_close=d.dates + hours(23);
    d.dates_full=sort([d.dates_open;d.dates_mid;d.dates_close]);
    
    d.open=data{2};
    d.high=data{3};
    d.low=data{4};
    d.close=data{5};
    d.volume=data{7};
    
    d.price=[d.open(:)';d.high(:)';d.close(:)'];
    d.price=d.price(:);
    
    save(d.mat_path,'d');
else
    load(d.mat_path);
end



%%
if 1 & strcmp(ticker,'OIH')
    dt=@(y,m,d)datetime(y,m,d);
%     figure
%     plot(d.dates_close,d.close)

    ydates=[dt(2001,4,11),   dt(2002,4,8),    dt(2003,4,7),     dt(2004,4,6),     dt(2005,4,6),     dt(2006,2,6),     dt(2007,2,21),   dt(2008,6,30),   dt(2009,6,30),  dt(2012,6,29),   dt(2018,1,22),  dt(2019,1,18),  dt(2020,3,4),  dt(2021,1,14),  dt(2021,9,30),  dt(2022,3,3)];
    yclose=[  549.0,            441.9,           362.67,           454.13,           661.33,            1024.6,            905.87,           1480.07,        651.20,           712.80,        587.40,        344.8,          174.60,       187.2,           197.01,        253.25];

    ny=numel(ydates);

    yrat=[];
    for i=1:ny
        ind=find(d.dates==ydates(i));
        yrat(i)=yclose(i)/d.close(ind);
    end

    ydn=days(ydates-d.dates_close(1));
    ddn=days(d.dates_close-d.dates_close(1));
    ddf=days(d.dates_full-d.dates_full(1));
    
    yratc=spline(ydn,yrat,ddn);
    yratf=spline(ydn,yrat,ddf);
    
    d.close=d.close.*yratc;
    d.price=d.price.*yratf;
    
%     hold on
%     scatter(ydates,yclose)
%     plot(d.dates_close,yratf.*d.close)
%     hold off
    
end
