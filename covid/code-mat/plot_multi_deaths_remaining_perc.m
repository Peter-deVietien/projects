cca
d1=load('data/percent_deaths_remaining_fast.mat');
d2=load('data/percent_deaths_remaining_expected.mat');
d3=load('data/percent_deaths_remaining_slow.mat');

%%
vax_perc1=cumsum(d1.vaccines_per_day)/sum(d1.pop_bins);
vax_perc2=cumsum(d2.vaccines_per_day)/sum(d2.pop_bins);
vax_perc3=cumsum(d3.vaccines_per_day)/sum(d3.pop_bins);

start_date=datetime(2020,12,19);
d1.days=start_date:caldays(1):start_date+caldays(d1.ndays-1);
d2.days=start_date:caldays(1):start_date+caldays(d2.ndays-1);
d3.days=start_date:caldays(1):start_date+caldays(d3.ndays-1);

%%
plot(d1.days,d1.v_perc*100,'linewidth',8,'color','red')
hold on
plot(d2.days,d2.v_perc*100,'linewidth',8,'color','green')
plot(d3.days,d3.v_perc*100,'linewidth',8,'color','blue')
hold off

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
text(datetime(2021,3,1),-20,'@peterdevietien','fontsize',25)

txtfntsize=15;
txtdate=datetime(2020,12,19);
k(1)=text(txtdate,-11.4,'Assumptions:','fontsize',txtfntsize);
k(2)=text(txtdate,-14.5,'1) 50/50 mix of Pfizer and Moderna vaccines','fontsize',txtfntsize);
k(3)=text(txtdate,-17.6,'2) 55% efficacy 10 days after first shot, 95% 10 days after second shot','fontsize',txtfntsize);

k(4)=text(txtdate,-22.5,'Population data from 2018 US Census','fontsize',txtfntsize);
k(5)=text(txtdate,-25.6,'COVID Deaths-age data from CDC Feb 1st - Dec 16th','fontsize',txtfntsize);
k(6)=text(txtdate,-28.7,'Real world ''X'' vaccine data from CDC','fontsize',txtfntsize);

for i=1:6
    k(i).FontAngle='italic';
end

%%
hold on
plot([datetime('now') datetime('now')],[0 14],'k--')
plot([datetime('now') datetime('now')],[25 100],'k--')
hold off


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yyaxis right
skat=scatter(d1.days,vax_perc1*100,100,'red','filled');
%skat.MarkerFaceAlpha=0.5;

hold on
skat=scatter(d2.days,vax_perc2*100,100,'green','filled');
%skat.MarkerFaceAlpha=0.5;
skat=scatter(d3.days,vax_perc3*100,100,'blue','filled');
%skat.MarkerFaceAlpha=0.5;
hold off

ylim([0 25])
ylabel('Percent Vaccinated (dots)','fontsize',30)

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
scatter(datetime(2021,1,7),5.92/330*100,800,'xk','linewidth',3)
hold off
text(datetime(2020,12,20),4.9,sprintf('X''s are real world data\n%.2f%% as of Jan 7th',5.92/330*100),'fontsize',20)
%text(datetime(2020,12,16),3.6,sprintf('X''s are current number \ndistributed (CDC)'),'fontsize',20)

%%

ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
grid on
fig=gcf;
fig.Position=[1 65 1115 740];
ax.Position=[0.1300 0.2000 0.7750 0.6134];


xticks(datetime(2020,12,1):calmonths(1):datetime(2021,4,1))
xlim([start_date datetime(2021,4,1)])

datetick('x','mmm-dd')
xlim([start_date datetime(2021,4,1)])


%%



set(0,'defaultlinelinestyle','-')

[~,ind50f]=min(abs(d1.v_perc-0.50));
[~,ind70f]=min(abs(d1.v_perc-0.30));

[~,ind50s]=min(abs(d3.v_perc-0.50));
[~,ind70s]=min(abs(d3.v_perc-0.30));

hold on
plot([d1.days(ind50f) d3.days(ind50s)],[50 50]/4,'k-','linewidth',5)
plot([d1.days(ind50f) d1.days(ind50f)],[46 54]/4,'k-','linewidth',5)
plot([d3.days(ind50s) d3.days(ind50s)],[46 54]/4,'k-','linewidth',5)
plot([start_date d1.days(ind50f)],[50 50]/4,'k--','linewidth',4)

plot([d1.days(ind70f) d3.days(ind70s)],[30 30]/4,'k-','linewidth',5)
plot([d1.days(ind70f) d1.days(ind70f)],[26 34]/4,'k-','linewidth',5)
plot([d3.days(ind70s) d3.days(ind70s)],[26 34]/4,'k-','linewidth',5)
plot([start_date d1.days(ind70f)],[30 30]/4,'k--','linewidth',4)
hold off

day50f=datestr(d1.days(ind50f),'mmm dd');
day50s=datestr(d3.days(ind50s),'mmm dd');
day70f=datestr(d1.days(ind70f),'mmm dd');
day70s=datestr(d3.days(ind70s),'mmm dd');

title_str=sprintf('US COVID Daily Deaths During Vaccine Rollout\n50%% Reduction: %s - %s\n70%% Reduction: %s - %s',day50f,day50s,day70f,day70s);
title(title_str,'fontsize',30)

%%
lgn=legend('Rapid Rollout','Projected Rollout','Slow Rollout','Daily Deaths');
lgn.Position(1)=0.1365;
lgn.Position(2)=0.5163;
%%
print('post/multi_remaining_deaths','-dpng')