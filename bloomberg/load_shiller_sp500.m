function s=load_shiller_sp500

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
k=readtable('data/shiller_sp500.xls.xls','Sheet','Data','Range','A8:L3000');

%% Remove nans
ind=isnan(k.Date);
k(ind,:)=[];

year=round(k.Date,0);
month=round((k.Date-year)*100,0);


s.dates=datetime(year,month,31);
s.price=k.P;
s.dividends=k.D;
s.earnings=k.E;
s.cpi=k.CPI;

