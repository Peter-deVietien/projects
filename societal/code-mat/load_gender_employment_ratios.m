warning('off','MATLAB:table:ModifiedAndSavedVarnames')
%%
mt=readtable('../data/male_employment_usa.csv');

m=struct();

m.edates=mt.DATE;
m.employed=mt.LNS12000001;

um=readtable('../data/WPP2019_POP_F01_2_TOTAL_POPULATION_MALE.xlsx','Sheet','transpose');

years=um.Region_Subregion_CountryOrArea_;
years=str2num(cell2mat(years));

m.udates=datetime(years,1,1);
m.pop=um.UnitedStatesOfAmerica;

m.pop=dspline(m.udates,m.pop,m.edates);
m.ratio=m.employed./m.pop*100;

%%
ft=readtable('../data/female_employment_usa.csv');
f=struct();

f.edates=ft.DATE;
f.employed=ft.LNS12000002;

uf=readtable('../data/WPP2019_POP_F01_3_TOTAL_POPULATION_FEMALE.xlsx','Sheet','transpose');

years=uf.Region_Subregion_CountryOrArea_;
years=str2num(cell2mat(years));

f.udates=datetime(years,1,1);
f.pop=uf.UnitedStatesOfAmerica;

f.pop=dspline(f.udates,f.pop,f.edates);
f.ratio=f.employed./f.pop*100;
