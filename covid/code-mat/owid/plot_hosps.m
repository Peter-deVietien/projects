function plot_hosps(t,country,dma)

if ~exist('dma','var')
    dma=1;
end

sel=ismember(t.location,country);

dates=t.date(sel);
hosps=moving_average(dates,t.hosp_patients_per_million(sel),dma);

plot(dates,hosps)