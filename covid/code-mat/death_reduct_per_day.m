function death_reduct = death_reduct_per_day(days)

%% Average of pfizer and moderna efficacy timing: 
%% 55% after first shot, 95% after second shot
model=1;
death_reduct=0;
pf_eff=0;
md_eff=0;

if model==1
    shot1eff=0.95;
    shot2eff=1-shot1eff;
    %% Pfizer
    if days<=21
        x0=12;
        k=1.5;
        pf_eff= shot1eff./(1+exp(-k*(days-x0)));
    else
        x0=21+12;
        k=1.5;
        pf_eff= shot1eff + shot2eff./(1+exp(-k*(days-x0)));
    end
    
    %% Moderna
    if days<=28
        x0=12;
        k=1.5;
        md_eff= shot1eff./(1+exp(-k*(days-x0)));
        
    else
        x0=28+12;
        k=1.5;
        md_eff= shot1eff + shot2eff./(1+exp(-k*(days-x0)));
    end
end

if model==2

    %% Pfizer (booster 3 weeks after shot 1)
    if days<=21

        pf_eff= 0.55*min(days/10,1);
    else
        pf_eff = 0.55 + 0.4*min((days-21)/10,1);

    end

    %% Moderna (booster 4 weeks after shot 1)
    if days<=28

        md_eff= 0.55*min(days/10,1);
    else
        md_eff = 0.55 + 0.4*min((days-28)/10,1);
    end

end

death_reduct=(pf_eff + md_eff)/2;
