last_year=23 + 2000;
fileyear=str2num(regexp(filename,'\d\d','match','once'));

if (last_year-fileyear)>1
    years_covered=fileyear+2+2000;
    dates=datetime(years_covered-6,1,15):calmonths(1):datetime(years_covered-1,12,15);
end