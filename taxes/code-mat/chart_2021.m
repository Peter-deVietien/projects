cca

load('2020_2021_t1135.mat')

%%
usecname=[usecname;{'Total'}];
ns=numel(usecname);
totals=nan(365*2,ns);

for i=1:ns
    for j=1:365*2
        if i==ns
            totals(j,i)=sum(totals(j,1:ns-1));
        else
            totals(j,i)=sum(t{j,i}.callval)+t{j,i}.shareval;

        end
    end
end

%% Reduce from daily to monthly maximums
dates=datetime(2020,1,1)+[1:365*2];

mtotals=nan(24,ns);

for i=1:24
    sdate=datetime(2020,1,1)+calmonths(i-1);
    edate=datetime(2020,1,1)+calmonths(i);
    
    sind=find(dates>sdate,1,'first');
    eind=find(dates>=edate-1,1,'first');
    
    mtotals(i,:)=max(totals(sind:eind,:));
    
end


mtotals=max(mtotals,0);
mtotals(1:12,:)=[];

zeroinds=[];
for i=1:ns
    if sum(mtotals(:,i))==0;
        zeroinds=[zeroinds;i];
    end
end

mtotals(:,zeroinds)=[];
usecname(zeroinds)=[];

d=[1:12]';
mtotals=[d,mtotals];
usecname=[{'Months'};usecname];

tsla=ismember(usecname,'TSLA');
mtotals(:,tsla)=[];
usecname(tsla)=[];
tsla=ismember(usecname,'UCLE');
mtotals(:,tsla)=[];
usecname(tsla)=[];
tsla=ismember(usecname,'UCO');
mtotals(:,tsla)=[];
usecname(tsla)=[];
tsla=ismember(usecname,'USO');
mtotals(:,tsla)=[];
usecname(tsla)=[];


for i=1:size(mtotals,1)
    mtotals(i,end)=sum(mtotals(i,1:end-1));
end

mtotals(end,2:end)=0.7*mtotals(end,2:end);

sel=mtotals(:,end)>1e6;

mtotals(sel,end)=max(mtotals(sel,2:end-1),[],2);

%%
figure
plot(mtotals)

legend(usecname)

figure
b=bar([1:46],mtotals(end,:));
ax=gca;
ax.XTick=[1:46];
ax.XTickLabel=usecname;

csvwrite_with_headers('../post/2021_holdings.csv',mtotals,usecname)

