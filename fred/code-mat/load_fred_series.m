function [dates,values]=load_fred_series(series_key)

api_key='6ea8bc897958792e172daf0264c34e90';

url=sprintf('https://api.stlouisfed.org/fred/series/observations?series_id=%s&api_key=%s&file_type=json',series_key,api_key);

wrstruct=webread(url,'Timeout',15);

t=struct2table(wrstruct.observations);

%%
dates=datetime(t.date);
values=str2double(t.value);

%%
sel=isnan(values);
dates(sel)=[];
values(sel)=[];