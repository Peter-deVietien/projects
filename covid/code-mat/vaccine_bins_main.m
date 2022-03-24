close all
clearvars -except savename x0 k max_vpd

x0=40;
k=0.07;
max_vpd=2000;

tic
ndays=365;

get_age_bin;

nbins=numel(age_bin);
age_bin=age_bin(:);
vac_bin=false(nbins,1);
days_bin=zeros(nbins,1);
death_reduct_bin=zeros(nbins,1);
perc_bin=zeros(nbins,1);
v_perc=zeros(ndays,1);

vaccines_per_day=get_vaccinations_per_day(x0,k,max_vpd,ndays);
get_percents_per_bin

rand1_vax=12e3;
rand2_vax=53e3;

for d=1:ndays
    vpd=vaccines_per_day(d);
    
    %% Updated vaccinated
    selt=vac_bin==true;
    if sum(selt)<rand1_vax
        for v=1:round(vpd,0)
            self=(vac_bin==false)&(age_bin>35);
            rind=max(1,floor(sum(self)*rand(1)));
            vac_bin(rind)=true;
        end
    elseif sum(selt)<rand2_vax
        for v=1:round(vpd,0)
            self=(vac_bin==false)&(age_bin>65);
            rind=max(1,floor(sum(self)*rand(1)));
            vac_bin(rind)=true;
        end
    else
        for v=1:round(vpd,0)
            self=(vac_bin==false);
            rind=max(1,floor(sum(self)*rand(1)));
            vac_bin(rind)=true;
        end        
        
%         selt=vac_bin==true;
%         ct=vpd;
%         i=1;
%         while ct>0
%             if vac_bin(i)==false
%                 vac_bin(i)=true;
%                 ct=ct-1;
%             end
%             i=i+1;
%         end
        
    end

    %% Update days since vaccinated
    sel=vac_bin==true;
    days_bin(sel)=days_bin(sel)+1;
    
    %% Update death_reduct for bin
    for i=1:nbins
        death_reduct_bin(i)=death_reduct_per_day(days_bin(i));
    end
    %plot_efficies_bin_per_day
    
    v_perc(d)=sum((1-death_reduct_bin).*flipud(perc_bin));

end

if exist('savename','var')
    save_str=sprintf('data/%s',savename)
    save(save_str);
else
    save('data/percent_deaths_remaining.mat');
end
toc
