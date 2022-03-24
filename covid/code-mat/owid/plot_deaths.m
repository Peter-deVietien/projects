function plot_deaths(t,country,dma,scale)

if ~exist('dma','var')
    dma=1;
end

sel=ismember(t.location,country);

dates=t.date(sel);
deaths=moving_average(dates,t.new_deaths_per_million(sel),dma)*scale;

plot(dates,deaths)