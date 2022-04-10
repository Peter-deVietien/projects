cca

t=readtable('~/projects/taxes/data/trades_2020_2021.xlsx');

%%
dates=datetime(t.TradeDate);
orders=t.OrderType;
securities=t.Security;
quantity=t.Quantity;
exec_price=t.ExecutedPrice;
net_amount=t.NetAmount;

securities=regexprep(securities,'BRK.B','BRKB');

%% Get list of securities
nd=numel(dates);
secname=cell(nd,1);
call=false(nd,1);
put=false(nd,1);
stock=false(nd,1);

for i=1:nd
    security=securities{i};
    secname(i)={regexp(security,'[A-Z]{2,5}','match','once')};
    if strcmp(secname{i},'BRK')
        secname(i)={'BRKB'};
    end
    
    %%
    call(i)=strcmp(regexp(security,'CALL','match','once'),'CALL');
    put(i)=strcmp(regexp(security,'PUT','match','once'),'PUT');
    stock(i)=strcmp(secname(i),security);
    
    if ~call(i) & ~put(i) & ~stock(i)
        error('ncalls + nputs + nstock doesn''t add up')
    end
end

%% Unique list of security names
usecname=unique(secname);
for i=1:numel(usecname)
    usecname{i}=usecname{i};
%    eval([usecname{i},'=nan(nd,1)']);
end


%% Loop through every date of the year, 
%% adding an asset structure for every security
for d=1:365*2
    date=datetime(2020,1,1)+d-1;
    
    
    %% Inherit structs from previous day (or new 1st day)
    if d>1
        t=[t;t(end,:)];
        
    else
        % Initialize table
        ns=numel(usecname);
        tablestr=[];
        for i=1:ns
            eval(sprintf('%s=struct();',usecname{i}));
            eval(sprintf('%s.shares=0;',usecname{i}));
            eval(sprintf('%s.shareval=0;',usecname{i}));
            eval(sprintf('%s.calls={};',usecname{i}));
            eval(sprintf('%s.callval=[];',usecname{i}));
            eval(sprintf('%s.callquant=[];',usecname{i}));
            eval(sprintf('%s.puts={};',usecname{i}));
            eval(sprintf('%s.putval=[];',usecname{i}));
            
            tablestr=[tablestr,usecname{i},','];
        end
        % remove last comma
        tablestr(end)=[];
        eval(['t=table(',tablestr,');']);
    end
    
    
    
    for i=1:nd
        if dates(i)==date
            disp(date)
            lsec=secname{i};
            lstruct=t.(lsec)(d);

            
            if call(i)
            
                sel=ismember(lstruct.calls,securities(i));
                if sum(sel)>1
                    error('repeat options')
                end
                if strcmp(orders{i},'Buy Open')
                    if sum(sel)
                        lstruct.callval(sel)=lstruct.callval(sel)+net_amount(i);
                        lstruct.callquant(sel)=lstruct.callquant(sel); + quantity(i);
                    else
                        lstruct.calls=[lstruct.calls; securities(i)];
                        lstruct.callval=[lstruct.callval; net_amount(i)];
                        lstruct.callquant=[lstruct.callquant; quantity(i)];
                    end
               
                elseif strcmp(orders{i},'Sell To Close')
                    if sum(sel)
                        lstruct.callquant(sel)=lstruct.callquant(sel)-quantity(i);
                        %If calls remain, update value of remaining calls
                        if lstruct.callquant(sel)>0
                            ppcall=net_amount(i)/quantity(i);
                            lstruct.callval(sel)=ppcall*lstruct.callquant(sel);
                        else
                            lstruct.calls(sel)=[];
                            lstruct.callval(sel)=[];
                            lstruct.callquant(sel)=[];
                        end
                    else
                        warning('Attempted to sell close option not in struct')
                    end
                    
                    
                elseif strcmp(orders{i},'Sell Open')
                    
                elseif strcmp(orders{i},'Buy Close')
                elseif strcmp(orders{i},'Option Expire')
                    lstruct.calls(sel)=[];
                    lstruct.callval(sel)=[];
                    lstruct.callquant(sel)=[];     
               
                end
                
            elseif put(i)
                continue
            elseif stock(i)
                if strcmp(orders{i},'Buy') | strcmp(orders{i},'Buy To Cover')
                    lstruct.shares=lstruct.shares+quantity(i);
                    lstruct.shareval=lstruct.shareval+net_amount(i);
                    
                elseif strcmp(orders{i},'Sell') | strcmp(orders{i},'Sell Short')
                    lstruct.shares=lstruct.shares-quantity(i);
                    if lstruct.shares==0
                        lstruct.shareval=0;
                    else
                        ppshare=net_amount(i)/quantity(i);
                        lstruct.shareval=lstruct.shares*ppshare;
                    end
                else
                    error('Stock was neither buy nor sell')
                end
            end
            
            t.(lsec)(d)=lstruct;

        elseif dates(i)>date
            break
        end
    end
end

save('2020_2021_t1135')
