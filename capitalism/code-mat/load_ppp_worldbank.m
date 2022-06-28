
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('../data/test2.xlsx','Sheet','Data','readrownames',true);

warning('off','MATLAB:table:ModifiedVarnamesRows2Vars')
t=rows2vars(t);

t.Properties.VariableNames(1)={'Year'};

t.Year=regexp(t.Year,'\d\d\d\d','match','once');
t.Year=datetime(t.Year,'InputFormat','yyyy');

country_list=t.Properties.VariableNames;