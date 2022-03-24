cca

t=readtable('data/test3.xlsx');

nx=size(t);

dates=datetime(2020,1,1):days(1):datetime(2020,12,31);
dates=dates(:);
ndate=numel(dates);
openlist=struct();
stocklist={};
pp=table(dates);
ct=1;
boct=0;
scct=0;

for d=1:ndate
    date=dates(d);
    dateinds=find(date==datetime(t.TradeDate,'InputFormat','MM/dd/uuuu'));

    for i=1:numel(dateinds)
        di=dateinds(i);

        ticker=regexp(t.Security(di),'[A-Z]{2,4}','match','once');

        if strcmp(t.OrderType{di},'Buy Open')
            boct=boct+1;
            %% Add stock to stocklist
            ind=contains(stocklist,ticker);
            if ~sum(ind)
                stocklist{end+1}=ticker{1};
            end

            %% Add transaction to openlist
            if isempty(fieldnames(openlist))
                openlist(1).ticker=ticker{1};
                openlist(1).security=t.Security{di};
                openlist(1).quantity=t.Quantity(di);
                openlist(1).cost=t.ExecutedPrice(di);
            else
                nlist=numel(openlist);
                openlist(nlist+1).ticker=ticker{1};
                openlist(nlist+1).security=t.Security{di};
                openlist(nlist+1).quantity=t.Quantity(di);
                openlist(nlist+1).cost=t.ExecutedPrice(di);
            end
        end

        %% Count total purchase price for all items in openlist

        %% Add column for stock if not exist
        if ~sum(contains(pp.Properties.VariableNames,stocklist{end}))
            eval(sprintf('%s=zeros(ndate,1);',stocklist{end}));
            eval(sprintf('pp=addvars(pp,%s);',stocklist{end}))
        end

        %% Remove closed positions, clean openlist
        if strcmp(t.OrderType{di},'Sell To Close') | strcmp(t.OrderType{di},'Option Expire')
            scct=scct+1;
            %% Get indicies that match security
            no=numel(openlist);
            olis=[];
            quantity=0;
            for n=1:no
                if strcmp(openlist(n).security,t.Security{di})
                    olis=[olis n];
                end
            end
            
            %% Sum quantity
            for i=1:numel(olis)
                oli=olis(i);
                quantity=quantity+openlist(oli).quantity;
            end
            
            %% Loop over openlist indicies, subtracting current quanitity and removing OL entry if zero
            removeind=[];
            for i=1:numel(olis)
                oli=olis(i);
                if (t.Quantity(di)-quantity) <= 0
                    quantity=quantity-t.Quantity(di);
                    removeind=[removeind oli];
                else
                    openlist(oli).quantity=openlist(oli).quantity-quantity;
                end
            end
            openlist(removeind)=[];
            
            

        end

    end
    
        %% Update amounts from open positions
    
    nop=numel(openlist);
    dateind=find(date==dates);
    if numel(fields(openlist))
        for i=1:nop
            pp(dateind,openlist(i).ticker)={pp{dateind,openlist(i).ticker}+openlist(i).quantity*openlist(i).cost*100};
        end
    end
    
    fprintf('%s %d\n',datestr(date),numel(openlist))
    %pause(0.05)
end

save('post/pp.mat','pp')