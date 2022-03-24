% Data gathered from table 1 on 
% https://www.census.gov/content/census/en/data/tables/2019/demo/age-and-sex/2019-age-sex-composition.html

data=readtable('data/2019gender_table1.csv',...
    'Format','%s %d %f',...
    'delimiter',',');

ages=[5,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,100]';

pop_age=double(data.Number(1:end-1));