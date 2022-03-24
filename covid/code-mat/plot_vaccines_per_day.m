cca

ndays=150;

get_vaccinations_per_day

start_date=datetime(2020,12,10);
days=start_date:caldays(1):start_date+caldays(ndays-1);

vax_perc=cumsum(vaccines_per_day);

plot(days,vax_perc/330e3)

