
%https://data.cdc.gov/NCHS/Provisional-COVID-19-Death-Counts-by-Sex-Age-and-S/9bhg-hcku

%data=readtable('data/cdf_data_11_28_2020.csv',...
%    'Format','%{MM/dd/yyy}D %{MM/dd/yyy}D %{MM/dd/yyy}D %s %s %s %d %d %d %d %d %d',...
%    'delimiter',',');

data=readtable('data/cdf_data_12_16_2020.csv',...
    'Format','%{MM/dd/yyy}D %{MM/dd/yyy}D %{MM/dd/yyy}D %s %s %s %d %d',...
    'delimiter',',');


ages=[1,4,14,24,34,44,54,64,74,84,100]';
c19deathbins=double(data.COVID_19_Deaths(1:end-1));
