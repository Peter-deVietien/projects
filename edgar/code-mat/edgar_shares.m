function [time,shares]=edgar_shares(cik)

url=sprintf('https://data.sec.gov/api/xbrl/companyfacts/CIK%s.json',cik);

k=webread(url);

scells=k.facts.dei.EntityCommonStockSharesOutstanding.units.shares;
ncells=numel(scells);

time=[];
shares=[];

for i=1:ncells
    if isstruct(scells)
        scell=scells(i);
    else
        scell=scells{i};
    end
    if ~strcmp(scell.form,'10-K')
        continue
    end
    time=[time datetime(scell.end)];
    shares=[shares scell.val];
end

if datetime()>time(end)
    time=[time datetime()];
    shares=[shares shares(end)];
end

time(end).Hour=0;
time(end).Minute=0;
time(end).Second=0;