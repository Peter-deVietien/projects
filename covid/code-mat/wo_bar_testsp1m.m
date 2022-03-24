cca
load_wo


sel=population<10e6;

country(sel)=[];
pos_tests(sel)=[];
deaths(sel)=[];
casesp1m(sel)=[];
deathsp1m(sel)=[];
tests(sel)=[];
testsp1m(sel)=[];
population(sel)=[];

sel=deathsp1m<180;

country(sel)=[];
pos_tests(sel)=[];
deaths(sel)=[];
casesp1m(sel)=[];
deathsp1m(sel)=[];
tests(sel)=[];
testsp1m(sel)=[];
population(sel)=[];

%%
bar(testsp1m)
ax=gca;
set(gca, 'XTick',1:numel(country))
set(gca, 'XTickLabel',country)