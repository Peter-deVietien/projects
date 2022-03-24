function data=process_quarterly_data(data)

data.year=zeros(data.nx(1),1);
data.quarter=zeros(data.nx(1),1);
data.month=zeros(data.nx(1),1);
data.day=zeros(data.nx(1),1);

for i = 1:data.nx(1)
    data.year(i)=str2num(data.x{i}(1:4));
    data.quarter(i)=str2num(data.x{i}(6:6));
    data.month(i)=(data.quarter(i)-1)*3+1;
    data.day(i)=1;
end

data.dates=datetime(data.year,data.month,data.day);
