function [odates,odata1,odata2]=colocate(dates1,data1,dates2,data2)

%% find common date ranges
sdate=max(dates1(1),dates2(1));
edate=min(dates1(end),dates2(end));

sel=dates1<sdate;
dates1(sel)=[];
data1(sel)=[];
sel=dates2<sdate;
dates2(sel)=[];
data2(sel)=[];

sel=dates1>edate;
dates1(sel)=[];
data1(sel)=[];
sel=dates2>edate;
dates2(sel)=[];
data2(sel)=[];

%% Arbitrary: Have dates2 match dates1 timing
d1days=days(dates1-dates2(1));
d2days=days(dates2-dates2(1));

odata1=data1;
odata2=spline(d2days,data2,d1days);
odates=dates1;

