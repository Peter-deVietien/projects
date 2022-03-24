function vaccines_per_day = get_vaccinations_per_day(x0,k,max_vpd,ndays)

% x0=34;
% k=0.07;
% max_vpd=2000;

vaccines_per_day=max_vpd./(1+exp(-k*([1:ndays]-x0)));

cs=cumsum(vaccines_per_day);

sind=find(cs>100e3,1,'first');

for i=sind:numel(vaccines_per_day)
    vaccines_per_day(i)=0.98*vaccines_per_day(i-1);
end