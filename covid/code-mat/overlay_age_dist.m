cca
cdf

load_age_dis

linage=linspace(1,ages(end),ages(end));
linperc=spline(ages,perc_people,linage);

yyaxis right
hold on
plot(linage,linperc*100)
hold off

ylabel('Age Percent of Population')
