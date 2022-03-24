cca
addpath('~/projects/covid/code-mat/owid')

k=dir('~/projects/covid/data/owid/owid-covid-data.csv');

if exist('~/projects/covid/data/owid/t.mat','file') & (days(now)-days(k.datenum))<0.5
    load('~/projects/covid/data/owid/t.mat')
elseif (days(now)-days(k.datenum))>=0.1
    system('curl https://covid.ourworldindata.org/data/owid-covid-data.csv -o ~/projects/covid/data/owid/owid-covid-data.csv');
    t=readtable('~/projects/covid/data/owid/owid-covid-data.csv');
    save('~/projects/covid/data/owid/t.mat','t')
else
    t=readtable('~/projects/covid/data/owid/owid-covid-data.csv');
end