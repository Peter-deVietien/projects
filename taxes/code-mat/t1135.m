cca

t=readtable('~/projects/taxes/data/trades2021.xlsx');

%%
dates=datetime(t.TradeDate);
orders=t.OrderType;
securities=t.Security;
quantity=t.Quantity;
exec_price=t.ExecutedPrice;
net_amount=t.NetAmount;

%% Get list of securities
secname=[];
call=[];
put=[];
stock=[];
nd=numel(dates);
for i=1:nd
    security=securities{i};
    secname=[secname {regexp(security,'[A-Z]{2,4}','match','once')}];
    if strcmp(secname(i),'BRK') | strcmp(secname(i),'BRKB')
        secname(i)={'BRK.B'};
    end
    
    %%
    call(i)=strcmp(regexp(security,'CALL','match','once'),'CALL');
    put(i)=strcmp(regexp(security,'PUT','match','once'),'PUT');
    stock(i)=strcmp(secname(i),security);
    
    if ~call(i) & ~put(i) & ~stock(i)
        error('ncalls + nputs + nstock doesn''t add up')
    end
end

%%
usecname=unique(secname);
for i=1:numel(usecname)
    usecname{i}=usecname{i};
    eval([usecname{i},'=nan(numel(dates),1)']);
end


%%
for i=1:nd
    sec=secname{i};
    order=orders{i};
    
    if stock(i)
    end
    
    if call(i) | put(i)
    end
    
end


