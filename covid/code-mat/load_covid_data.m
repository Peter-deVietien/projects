csv_path=sprintf('data/covid_tracking_us_data.csv');

csv_dir=dir(csv_path);
date_compare=datevec(csv_dir.datenum)<datevec(now);
if sum(date_compare(1:3))
    
    %data_cmd=sprintf('curl https://api.covidtracking.com/v1/us/current.csv > %s',csv_path);

    data_cmd=sprintf('curl https://api.covidtracking.com/v1/us/daily.csv > %s',csv_path);
    system(data_cmd);
end


data=readtable(csv_path);
data=flipud(data);

dates=datetime(string(data{:,1}),'inputformat','yyyyMMdd');
states=data{:,2};
positive=data{:,3};
negative=data{:,4};
pending=data{:,5};
current_hospitalized=data{:,6};
total_hospitalized=data{:,7};
current_icu=data{:,8};
total_icu=data{:,9};
current_ventilator=data{:,10};
total_ventilator=data{:,11};
recovered=data{:,12};
total_death=data{:,13};
hospitalized=data{:,15};
total_tests=data{:,18};
increase_deaths=data{:,20};
increase_hospitalized=data{:,21};
increase_positive=data{:,23};
increase_tests=data{:,24};

percent_positive=increase_positive./increase_tests;