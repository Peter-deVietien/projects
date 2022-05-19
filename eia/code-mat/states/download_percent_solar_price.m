cca

states={'AL','AK','AZ','AR','CA','CZ','CO','CT','DE','DC',...
    'FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA',...
    'ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',...
    'NJ','NM','NY','NC','ND','OH','OK','OR','PA','PR','RI',...
    'SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI',...
    'WY'};

nstates=numel(states);
addpath('../');
failed_states=[];
delind=[];

s.x={};
s.y=[];
s.nx=[];
s.year=[];
s.month=[];
s.day=[];
s.dates=[];

for i=1:nstates
    series_key_w=sprintf('ELEC.GEN.WND-%s-99.A',states{i});
    series_key_s=sprintf('ELEC.GEN.TSN-%s-99.A',states{i});
    series_key_a=sprintf('ELEC.GEN.ALL-%s-99.A',states{i});
    series_key_p=sprintf('ELEC.PRICE.%s-ALL.A',states{i});

    try

        [dinit,metadata1]=load_eia_series(series_key_w);
        dw(i)=process_annual_data(dinit);
        
        [dinit,metadata1]=load_eia_series(series_key_s);
        ds(i)=process_annual_data(dinit);
        
        [dinit,metadata1]=load_eia_series(series_key_a);
        da(i)=process_annual_data(dinit);  
        
        [dinit,metadata1]=load_eia_series(series_key_p);
        dp(i)=process_annual_data(dinit);
        
        
        
    catch
        fprintf('%s didn''t load\n',states{i});
        failed_states=[failed_states {states{i}}];
        delind=[delind i];
        dw(i)=s;
        ds(i)=s;
        da(i)=s;
        dp(i)=s;
    end
end

%%
remaining_states=states;
remaining_states(delind)=[];

ds(delind)=[];
dw(delind)=[];
da(delind)=[];
dp(delind)=[];

%%

save('eia-states-solar-wind-price','ds','dw','da','dp','remaining_states')
