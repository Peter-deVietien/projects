cca

k=0.2:0.2:2;
d=1;

x=0:100;
y=nan(numel(x),numel(k));

for i=1:numel(k)
    y(:,i)=exp((x-50).*(k(i)-d));
end

plot(x,y)

ylim([0 10])