cca

load 2020_2021_t1135.mat;

[a,b]=ismember(t.Properties.VariableNames,'TSLA');

k=t(:,a);

secval=[];
secdates=[];
for i=1:numel(k)
    secval=[secval sum(k{i,1}.callval + k{i,1}.shareval)];
end

plot(datetime(2020,1,1)+[1:365*2],secval)