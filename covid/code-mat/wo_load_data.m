
%data=readtable('worldometers_Sept_27_20.xlsx');
%data=readtable('worldometers_Aug_1_20.xlsx');
data=readtable('worldometers_Nov_4_20.xlsx');

country=data{:,2};
pos_tests=data{:,3};
deaths=data{:,4};
casesp1m=data{:,5};
deathsp1m=data{:,6};
tests=data{:,7};
testsp1m=data{:,8};
population=data{:,9};

pop=[];
for i=1:numel(population)
    pop(i)=str2num(population{i});
end
population=pop;