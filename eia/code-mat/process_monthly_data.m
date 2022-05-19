function data=process_monthly_data(data)

nd=data.nx(1);
dates=NaT(nd,1);

for i = 1:nd
    if ~isstr(data.x{i})
        continue
    end
    year=str2num(data.x{i}(1:4));
    month=str2num(data.x{i}(5:end));
    day=eomday(year,month);
    dates(i)=datetime(year,month,day);
end

data.dates=dates;
