
function [data,wrseries]=load_eia_series(series_key)

savename=regexprep(series_key,'\.','_');
save_path=sprintf('~/projects/eia/data/api/%s',savename);

k=dir([save_path,'.mat']);

if ~numel(k) | (days(datenum(now)-k.datenum)>1)
    api_key = '4Cgy5BurMNMAhbo0RBIu3s5FFyyo37QEVmW0uBoz';

    url=sprintf('https://api.eia.gov/series/?api_key=%s&series_id=%s', api_key, series_key);

    wrstruct=webread(url,'Timeout',15);
    wrseries=wrstruct.series;
    wrdata=flipud(wrstruct.series.data);

    ndata=numel(wrdata);
    data=struct;
    data.x=cell(ndata,1);
    data.y=zeros(ndata,1);
    
    errs=[];

    for i = 1:numel(wrdata)
        if ~isnumeric(wrdata{i}{2}) | isempty(wrdata{i}{2}) | ~isstr(wrdata{i}{1})
            errs=[errs i];
            continue
        else
            data.x(i)=wrdata{i}(1);
            data.y(i)=wrdata{i}{2};
        end


    end

    data.x(errs)=[];
    data.y(errs)=[];
    
    data.nx=[numel(data.x),2];
    
    %%
    

    save(save_path,'data','wrseries');
else
    %warning(['Loading data from cache for ',series_key])
    load(save_path)

end