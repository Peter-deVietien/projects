
function [data,wrseries]=load_eia_series(series_key)

api_key = '4Cgy5BurMNMAhbo0RBIu3s5FFyyo37QEVmW0uBoz';

url=sprintf('https://api.eia.gov/series/?api_key=%s&series_id=%s', api_key, series_key);

wrstruct=webread(url,'Timeout',15);
wrseries=wrstruct.series;
wrdata=wrstruct.series.data;

ndata=numel(wrdata);
data=struct;
data.x=cell(ndata,1);
data.y=zeros(ndata,1);

for i = 1:numel(wrdata)
    if ~isnumeric(wrdata{i}{2}) | isempty(wrdata{i}{2})
        continue
    end
    
    data.x(i)=wrdata{i}(1);
    data.y(i)=wrdata{i}{2};
end

data.x=flipud(data.x);
data.y=flipud(data.y);

data.nx=[ndata,2];



end