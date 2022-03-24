function plot_cases(t,country,dma)

if ~exist('dma','var')
    dma=1;
end

sel=ismember(t.location,country);

dates=t.date(sel);
cases=moving_average(dates,t.new_cases_per_million(sel),dma);

plot(dates,cases)