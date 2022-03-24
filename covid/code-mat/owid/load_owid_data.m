addpath('~/projects/covid/code-mat/owid')

k=dir('~/projects/covid/data/owid/owid-covid-data.csv');

%% Chose to redownload data or not

% Manual override
if ~exist('reload','var')
    reload=0;
end

%% If same day after 10pm MNT or next day after 10pm MNT
mattime = datetime(k.datenum,'ConvertFrom','datenum');
loadtime = datetime(now,'ConvertFrom','datenum');
dtime = loadtime - mattime;

if dtime > hours(24)
    reload=1;
elseif (loadtime.Day > mattime.Day) & (loadtime.Hour >= 22)
    reload = 1;
elseif (loadtime.Day == mattime.Day) & (loadtime.Hour >= 22) & (mattime.Hour < 22)
    reload = 1;
end

%% Load the data
if reload==1
    system('curl https://covid.ourworldindata.org/data/owid-covid-data.csv -o ~/projects/covid/data/owid/owid-covid-data.csv')
end

t=readtable('~/projects/covid/data/owid/owid-covid-data.csv');