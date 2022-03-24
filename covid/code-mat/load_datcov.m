cca

admis=readtable('../data/datcov/DATCOV.AggregateData/Admissions-WardUponAdmission-Table 1.csv');
disch=readtable('../data/datcov/DATCOV.AggregateData/Discharges-WardUponAdmission-Table 1.csv');
tdeaths=readtable('../data/datcov/DATCOV.AggregateData/Deaths-WardUponAdmission-Table 1.csv');

%%
admissiondates=datetime(admis.AdmissionDate,'Format','MM/dd/yyyy')+years(2000);
dischargedates=datetime(disch.OutcomeDate,'Format','MM/dd/yyyy')+years(2000);
deathdates=datetime(tdeaths.OutcomeDate,'Format','MM/dd/yyyy')+years(2000);

dates=(admissiondates(1):1:datetime)';

%%

ndates=numel(dates);

netward=zeros(ndates,1);
nethc=zeros(ndates,1);
neticu=zeros(ndates,1);


iadmis=ismember(dates,admissiondates);
idisch=ismember(dates,dischargedates);
ideath=ismember(dates,deathdates);


netward(iadmis)=netward(iadmis)+admis.GeneralWard;
netward(iadmis)=netward(iadmis)+admis.HighCare;
netward(iadmis)=netward(iadmis)+admis.IntensiveCareUnit;

netward(idisch)=netward(idisch)-disch.HighCare;
netward(idisch)=netward(idisch)-disch.IntensiveCareUnit;
netward(idisch)=netward(idisch)-disch.GeneralWard;

netward(ideath)=netward(ideath)-tdeaths.GeneralWard;
netward(ideath)=netward(ideath)-tdeaths.HighCare;
netward(ideath)=netward(ideath)-tdeaths.IntensiveCareUnit;

%%
ward=zeros(ndates,1);
hc=zeros(ndates,1);
icu=zeros(ndates,1);

ward=cumsum(netward);
