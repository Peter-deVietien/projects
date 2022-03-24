function data=process_monthly_data(data)

data.year=zeros(data.nx(1),1);
data.month=zeros(data.nx(1),1);
data.day=zeros(data.nx(1),1);

for i = 1:data.nx(1)
    if ~isstr(data.x{i})
        continue
    end
    data.year(i)=str2num(data.x{i}(1:4));
    data.month(i)=str2num(data.x{i}(5:end));
    data.day(i)=1;
end

data.dates=datetime(data.year,data.month,data.day);
