clear
close all

t0=datetime(2021,12,15);
c0=1e6;

vtau=[2 3 4 5];
nt=numel(vtau);

t=1:0.1:70;
dates=[t0 t0+t];
c=[];
lgs=[];

for i=1:nt

    tau=vtau(i);
    c=[c c0*2.^(t/tau)'];
    lgs=[lgs {sprintf('Doubling: %.1f days',tau)}];


    
end

sel=c>8e9;
c(sel)=nan;

semilogy(t0+t,c,'linewidth',3)

grid on

hold on
plot([dates(1) dates(end)],[1 1]*8e9,'m','linewidth',3)

ind=find(c(:,1)>1e9,1,'last');
plot([dates(ind) dates(ind)],[1e5 8e9],'r--')

ind=find(c(:,end)>1e9,1,'last');
plot([dates(ind) dates(ind)],[1e5 8e9],'r--')
hold off

lgs=[lgs {sprintf('Global Population')}];


ylim([5e5 1e10])
xlim([dates(2) dates(end)])

lgn=legend(lgs);
lgn.Position=[0.3966 0.2614 0.2228 0.1851];

ax=gca;
ax.FontSize=16;

ax.XTick=[dates(1):7:dates(end)];
ax.XTickLabel=datestr(ax.XTick,'mmm dd');


fig=gcf;
fig.Position=[-987 223 725 505];

title_str=sprintf('Global Omicron Cases\nAssuming 1 Million Global Infections %s',datestr(dates(1)));
title(title_str)

ylabel('Global Infections')

text(datetime(2022,2,7),7e5,'@peterdevietien','fontsize',16)


print('~/projects/covid/post/omicron/global_cases','-dpng')