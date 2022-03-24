function cstr=num2cstr(num)

cstr=[];
it=1;

while log10(num)>=0
    digs=mod(num,1000);
    
    istr=num2str(digs);
    while numel(istr)<3
        istr=['0',istr];
    end
    
    if it==1
        cstr=istr;
    else
        cstr=[istr,',',cstr];
    end
    num=floor(num/1000);
    it=it+1;
end


%% Pare off first 0's

while cstr(1)=='0'
    cstr(1)=[];
end
