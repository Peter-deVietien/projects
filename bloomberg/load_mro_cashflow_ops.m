function [dates,cashflow]=mro_cashflow_ops()

t=readtable('data/mro_cashflow_ops.csv');

dates=NaT(size(t,1),1);
quarts=t.Var1;
years=t.Var2;
cashflow=t.Var3;

for i=1:size(t,1)
    if strcmp(quarts{i},'Q1')
        dates(i)=eomdate(datetime(years(i),3,25));
    elseif strcmp(quarts{i},'Q2')
        dates(i)=eomdate(datetime(years(i),6,25));
    elseif strcmp(quarts{i},'Q3')
        dates(i)=eomdate(datetime(years(i),9,25));
    elseif strcmp(quarts{i},'Q4')
        dates(i)=eomdate(datetime(years(i),12,25));
    end
end