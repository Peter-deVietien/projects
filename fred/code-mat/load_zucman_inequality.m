function t=load_zucman_inequality

warning('off','MATLAB:table:ModifiedAndSavedVarnames');

t=readtable('../data/Zucman_inequality_2016.xlsx');

t.Properties.VariableNames{1}='dates';
t.Properties.VariableNames{5}='top1pct';

t.dates=datetime(t.dates,1,1);