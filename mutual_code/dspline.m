function out=dspline(dates,data,xdates)

ddays=days(dates-xdates(1));
xdays=days(xdates-xdates(1));

out=spline(ddays,data,xdays);