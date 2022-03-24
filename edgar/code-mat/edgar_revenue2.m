function [tstart,tend,rev]=edgar_revenue(cik)

url=sprintf('https://data.sec.gov/api/xbrl/companyfacts/CIK%s.json',cik);

k=webread(url);

revenues=k.facts.us_gaap.Revenues.units.USD;

edgar_revenue_exceptions

nforms=numel(revenues);

tstart=[];
tend=[];
rev=[];

tanstart=[];
tanend=[];
anrev=[];

for i=1:nforms
    form=revenues{i}.form;
    fstart=datetime(revenues{i}.start);
    fend=datetime(revenues{i}.end);
    if strcmp(form,'10-Q') & (days(fend-fstart)<110) & (days(fend-fstart)>70)
        tstart=[tstart fstart];
        tend=[tend fend];
        rev=[rev revenues{i}.val];
    end
    if strcmp(form,'10-K') & (days(fend-fstart)<400) & (days(fend-fstart)>300)
        tanstart=[tanstart fstart];
        tanend=[tanend fend];
        anrev=[anrev revenues{i}.val];
    end    
    
end

%%

[~,uinds]=unique(tstart);
tstart=tstart(uinds);
tend=tend(uinds);
rev=rev(uinds);

[~,uinds]=unique(tanstart);
tanstart=tanstart(uinds);
tanend=tanend(uinds);
anrev=anrev(uinds);

%%
tyears=tstart(1).Year:tstart(end).Year;
nyears=numel(tyears);

for i=1:nyears
    sel=tstart.Year==tyears(i);
    if sum(sel) ~= 3
        continue
    end
    first3qrev=sum(rev(sel));
    
    sel=tanstart.Year==tyears(i);
    q4rev=anrev(sel)-first3qrev;
    
    tstart=[tstart datetime(tyears(i),10,1)];
    tend=[tend datetime(tyears(i),12,31)];
    rev=[rev q4rev];
end


%% Sort that mess
[~,I]=sort(tstart);
tstart=tstart(I);
tend=tend(I);
rev=rev(I);

