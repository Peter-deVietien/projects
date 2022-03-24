cca
%% Numbers for DOW
dates=[datetime(1980,12,5) datetime(2020,12,2)];
prices=[956 29638];

%% Calculate the S&P
dates=[datetime(1980,12,5) datetime(2020,12,2)];
prices=[134 3669];

dtime=dates(end)-dates(1);
years=years(dtime);


%p=p0*a^y
%p/p0=a^y
%ln(p/p0)=y*ln(a)
%ln(p/po)/y=ln(a)
%exp(ln(p/po)/y)=a
%p/p0^1/y=1+i

%i=p/p0^(1/y)-1;
p=prices(end);
p0=prices(1);
y=years;

i=(p/p0)^(1/y)-1;