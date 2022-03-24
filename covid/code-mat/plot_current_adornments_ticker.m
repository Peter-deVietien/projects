plot_current

%% George Floyd
[d_ind,~]=find(dates==datetime(2020,06,06));

axis manual

hold on;
plot([dates(d_ind) dates(d_ind)],[0 1e100],'k--','linewidth',4)
hold off

%% Pre June peak
yyaxis left

[j_ind,b]=find(dates>datetime(2020,06,01),1,'first');

[ip,ip_ind]=max(current_icu(1:j_ind));
[ih,ih_ind]=max(current_hospitalized(1:j_ind));
[iv,iv_ind]=max(current_ventilator(1:j_ind));
[ipi,ipi_ind]=max(percent_icu(1:j_ind));
[ipp,ipp_ind]=min(percent_positive(20:j_ind));

fprintf('ICU %% of maximum: %.1f\n',current_icu(end)/current_icu(ip_ind))
fprintf('Hospitalized %% of maximum: %.1f\n',current_hospitalized(end)/current_hospitalized(ip_ind))

%%
pim_str=sprintf('%2.0f%% of max',current_icu(end)/current_icu(ip_ind)*100);
phm_str=sprintf('%2.0f%% of max',current_hospitalized(end)/current_hospitalized(ih_ind)*100);
pvm_str=sprintf('%2.0f%% of max',current_ventilator(end)/current_ventilator(iv_ind)*100);
pip_str=sprintf('%2.0f%% of max',percent_icu(end)/percent_icu(ipi_ind)*100);
pipp_str=sprintf('%2.0f%% over min',percent_positive(end)/percent_positive(ipp_ind)*100-1);

phm_x=dates(end);
phm_y=current_hospitalized(end);
text(phm_x,phm_y,phm_str,'fontsize',18)

pim_x=dates(end)+1;
pim_y=current_icu(end);
text(pim_x,pim_y,pim_str,'fontsize',18)

pvm_x=dates(end)+1;
pvm_y=current_ventilator(end);
text(pvm_x,pvm_y,pvm_str,'fontsize',18)

pip_x=dates(end)+1;
pip_y=percent_icu(end);
yyaxis right
text(pip_x,pip_y,pip_str,'fontsize',18)

pipp_x=dates(end)+1;
pipp_y=percent_positive(end);
%text(pipp_x,pipp_y,pipp_str,'fontsize',18)

yyaxis left

xlim([datetime(2020,01,01) datetime(2021,01,15)])

lgh.Location='east';

%%
ticker='OXY';
load_ticker_data

yyaxis left

nph=numel(h);

hold on
h(nph+1)=plot(dates_full,price*1e3,'b-','linewidth',1);
hold on
lgs=[lgs {sprintf('%s Price',ticker)}];

legend(h,lgs)