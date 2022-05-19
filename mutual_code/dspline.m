function [xdates,out]=dspline(dates,data,xdates)

%% Cut xdates preceeding or exceeding 'dates'
sel=(xdates<dates(1)) | (xdates>dates(end));
xdates(sel)=[];

%%
ddays=days(dates-xdates(1));
xdays=days(xdates-xdates(1));

out=spline(ddays,data,xdays);