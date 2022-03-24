cca

d.ndays=365;
x0=40;
k=0.07;
max_vpd=2000;

d.vaccines_per_day = get_vaccinations_per_day(x0,k,max_vpd,d.ndays);

vax_perc=cumsum(d.vaccines_per_day)/330e3;

start_date=datetime(2020,12,19);
d.days=start_date:caldays(1):start_date+caldays(d.ndays-1);

%%
death_color=[0.8500, 0.3250, 0.0980];
plot(d.days,vax_perc*100,'linewidth',8,'color',death_color)

hold on
scatter(datetime(2020,12,19),0.08,800,'xk','linewidth',3)
scatter(datetime(2020,12,20),0.17,800,'xk','linewidth',3)
scatter(datetime(2020,12,22),0.30,800,'xk','linewidth',3)
scatter(datetime(2020,12,25),0.59,800,'xk','linewidth',3)
scatter(datetime(2020,12,27),0.64,800,'xk','linewidth',3)
scatter(datetime(2020,12,29),0.84,800,'xk','linewidth',3)
scatter(datetime(2021,1,2),1.28,800,'xk','linewidth',3)
%scatter(datetime(2021,1,4),4.56/330*100,800,'xk','linewidth',3)
%scatter(datetime(2021,1,5),4.84/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,6),5.31/330*100,800,'xk','linewidth',3)
%scatter(datetime(2021,1,7),5.92/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,8),6.69/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,11),8.99/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,15),10.60/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,19),13.60/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,20),14.27/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,22),16.24/330*100,800,'xk','linewidth',3)

scatter(datetime(2021,2,5),28.91/330*100,800,'xk','linewidth',3)
