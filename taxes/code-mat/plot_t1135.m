cca

load('2020_2021_t1135.mat')

%%
usecname=[usecname;{'Total'}];
ns=numel(usecname);
totals=nan(365*2,ns);

for i=1:ns
    for j=1:365*2
        if i==ns
            totals(j,i)=sum(totals(j,1:ns-1));
        else
            totals(j,i)=sum(t{j,i}.callval)+t{j,i}.shareval;

        end
    end
end

%%
c=1;
lgs=[];
for i=1:ns
    if max(totals(:,i))>700000
        hold on
        p(c)=plot(datetime(2020,1,1)+[1:365*2],totals(:,i),'linewidth',3);
        hold off
        lgs=[lgs {usecname{i}}];
        if i==ns
            p(c).Color=[0 0 0 0.3];
        end
        c=c+1;

    end
end


ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;
ax.FontSize=20;
grid on

legend(p,lgs)

