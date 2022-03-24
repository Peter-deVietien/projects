cca
d=load('data/percent_deaths_remaining.mat');

%%
vax_perc=cumsum(d.vaccines_per_day)/sum(d.pop_bins);

start_date=datetime(2020,12,19);
d.days=start_date:caldays(1):start_date+caldays(d.ndays-1);

%%
death_color=[0.8500, 0.3250, 0.0980];
plot(d.days,d.v_perc*100,'linewidth',8,'color',death_color)

%%
load_covid_data
avg_deaths=moving_average(dates,increase_deaths,7);
sind=find(dates==(start_date+10));
norm_deaths=avg_deaths/max(avg_deaths*1.02)*100;

hold on
plot(dates,norm_deaths,'k-','linewidth',8)
hold off

%%

ax=gca;
ax.FontSize=25;

%%
ylabel('Percent Daily Deaths','fontsize',30)
ylim([0 100])
yticks(0:10:100)

%%
text(datetime(2021,4,1),-20,'@peterdevietien','fontsize',25)

txtfntsize=15;
txtdate=datetime(2020,12,19);
k(1)=text(txtdate,-11.4,'Assumptions:','fontsize',txtfntsize);
k(2)=text(txtdate,-14.5,'1) 50/50 mix of Pfizer and Moderna vaccines','fontsize',txtfntsize);
k(3)=text(txtdate,-17.6,'2) 55% efficacy 14 days after first shot, 95% 14 days after second shot','fontsize',txtfntsize);

k(4)=text(txtdate,-22.5,'Population data from 2019 US Census','fontsize',txtfntsize);
k(5)=text(txtdate,-25.6,'COVID Deaths-age data from CDC Feb 1st - Dec 16th','fontsize',txtfntsize);
k(6)=text(txtdate,-28.7,'Real world ''X'' vaccine data from CDC','fontsize',txtfntsize);

for i=1:6
    k(i).FontAngle='italic';
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yyaxis right
vax_color=[0, 0.4470, 0.7410];
hold on
skat=scatter(d.days,vax_perc*100,100,vax_color,'filled');
hold off

ylim([0 100])
rylim=ylim;
ylabel('Percent Vaccinated (dots)','fontsize',30)

%%
hold on
plot([datetime('today') datetime('today')],[0 14]/(100/rylim(2)),'k--')
plot([datetime('today') datetime('today')],[25 100]/(100/rylim(2)),'k--')
hold off

%%

% xdates=[datetime(2020,12,19),datetime(2020,12,20),datetime(2020,12,22),...
%     datetime(2020,12,25),datetime(2020,12,27),datetime(2020,12,29),...
%     datetime(2021,1,2),datetime(2021,1,4),datetime(2021,1,5),datetime(2021,1,6),...
%     datetime(2021,1,7)];
% xpercs=[0.264, 0.561, 0.990, 1.947, 2.112, 2.772, 4.224,...
%     4.56,4.84,5.31,5.92];

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
%scatter(datetime(2021,1,23),17.39/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,24),18.50/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,26),19.90/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,27),20.69/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,29),22.86/330*100,800,'xk','linewidth',3)
%scatter(datetime(2021,1,30),24.06/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,1,31),25.20/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,2,5),28.91/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,2,8),32.34/330*100,800,'xk','linewidth',3)
%scatter(datetime(2021,2,9),32.87/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,2,10),33.78/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,2,16),39.67/330*100,800,'xk','linewidth',3)
scatter(datetime(2021,2,18),41.02/330*100,800,'xk','linewidth',3)

%scatter(datetime(2021,2,1),10,700,'ok','linewidth',3)

hold off

txt=text(datetime(2021,1,1),7,sprintf('X''s are CDC data\n%.1f%% as of Feb 18th',41.02/330*100),'fontsize',20);
txt.HorizontalAlignment='center';
txt.Position=[20 18]

%%

ax.YAxis(1).Color = death_color;
ax.YAxis(2).Color = vax_color;
grid on
fig=gcf;
fig.Position=[1 65 1115 740];
ax.Position=[0.1300 0.2000 0.7750 0.6134];


xticks(datetime(2020,12,1):calmonths(1):datetime(2021,6,1))
xlim([start_date datetime(2021,6,1)])

datetick('x','mmm-dd')
xlim([start_date datetime(2021,6,1)])


%%



set(0,'defaultlinelinestyle','-')

[~,ind50]=min(abs(d.v_perc-0.50));
[~,ind70]=min(abs(d.v_perc-0.30));

hold on
% plot([d1.days(ind50f) d3.days(ind50s)],[50 50]/4,'k-','linewidth',5)
% plot([d1.days(ind50f) d1.days(ind50f)],[46 54]/4,'k-','linewidth',5)
% plot([d3.days(ind50s) d3.days(ind50s)],[46 54]/4,'k-','linewidth',5)
plot([start_date d.days(ind50)],[50 50]/(100/rylim(2)),'k--','linewidth',4)
% 
% plot([d1.days(ind70f) d3.days(ind70s)],[30 30]/4,'k-','linewidth',5)
% plot([d1.days(ind70f) d1.days(ind70f)],[26 34]/4,'k-','linewidth',5)
% plot([d3.days(ind70s) d3.days(ind70s)],[26 34]/4,'k-','linewidth',5)
plot([start_date d.days(ind70)],[30 30]/(100/rylim(2)),'k--','linewidth',4)
hold off

day50=datestr(d.days(ind50),'mmm dd');
day70=datestr(d.days(ind70),'mmm dd');

title_str=sprintf('Percent Death Reduction From Vaccine\nAssuming December daily infection rate  \n70%% Reduction around %s',day70);
title(title_str,'fontsize',30)

%%
[lgn,b,c,d]=legend('Percent Daily Deaths','Actual Daily Deaths','Percent Vaccinated');
lgn.Position=[0.5993 0.6068 0.2762 0.1162];
b(8).Children.MarkerSize=14;
%%
print('post/plot_remaining_deaths','-dpng')