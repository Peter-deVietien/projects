
hold on
plot([datetime(1974,10,11) datetime(1974,10,11)],[0 23],'k--')
%plot([datetime(1979,3,16) datetime(1979,3,16)],[0 23],'k--')
plot([datetime(1979,3,28) datetime(1979,3,28)],[0 23],'k--')
plot([datetime(1986,4,26) datetime(1986,4,26)],[0 23],'k--')
plot([datetime(1987,12,15) datetime(1987,12,15)],[0 23],'k--')
hold off

t1=text(datetime(1974,10,11),23.5,'1','fontsize',19,'horizontalalignment','center');
t2=text(datetime(1979,03,16),23.5,'2a, 2b','fontsize',19,'horizontalalignment','center');
t3=text(datetime(1986,04,26),23.5,'3','fontsize',19,'horizontalalignment','center');
t4=text(datetime(1987,12,15),23.5,'4','fontsize',19,'horizontalalignment','center');

yshift=0;
xtxt=datetime(1990,1,1);
fntsize=15;

txt1=text(xtxt,15.66,'1','fontsize',fntsize);
txt1.String=sprintf('1. Nuclear Reorganization Act 1974: Pro \n  nuclear Atomic Energy Commission replaced\n  with Nuclear Regulatory Commission (NRC)');

txt2a=text(xtxt,12.57,'2','fontsize',fntsize);
txt2a.String=sprintf('2a. Three Mile Island: Zero deaths, infinite news');

txt2b=text(xtxt,10.11,'3','fontsize',fntsize);
txt2b.String=sprintf('2b. China Syndrome: Jane Fonda nuclear\n disinformation movie');

txt3=text(xtxt,6.67,'3','fontsize',fntsize);
txt3.String=sprintf('3. Chernobyl: Worst nuclear accident possible\nFewer deaths & destruction than most \ndam breaks.  Massive nuclear disinformation');

txt4=text(xtxt,2.67,'4','fontsize',fntsize);
txt4.String=sprintf('4. "NRC Coziness with Industry": Legislating\nanti-nuclear sentiment from progressives and \n their media.  Killed U.S. Nuclear');
