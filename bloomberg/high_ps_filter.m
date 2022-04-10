clear
close all

%%
load_high_ps;

omarkcap=markcap;
oepsyoy=epsyoy;
oeps=eps;
oevsales=evsales;
orev=rev;
orevyoy=revyoy;
oticker=ticker;
odebtasset=debtasset;
oncompanies=numel(ticker);


%% Establish filters
filt_markcap=4e9;
filt_debtasset=15;
filt_evsales=14;
filt_rev=1e9;
filt_revyoy=20;
filt_eps=0;
filt_epsyoy=20;


%% Market Cap Filter
osel=omarkcap>filt_markcap & ~isnan(omarkcap);
sel=markcap>filt_markcap | isnan(markcap);
high_ps_filter_sel
fprintf('Market Cap Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))

%% EV/Sales Filter
osel=oevsales>filt_evsales & ~isnan(oevsales);
sel=evsales>filt_evsales | isnan(evsales);
high_ps_filter_sel
fprintf('EV/Sales Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))


%% Revenue
osel=orev>filt_rev & ~isnan(orev);
sel=rev>filt_rev | isnan(rev);
high_ps_filter_sel
fprintf('Revenue Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))

%% Revenue YoY
osel=orevyoy<filt_revyoy & ~isnan(orevyoy);
sel=revyoy<filt_revyoy | isnan(revyoy);
high_ps_filter_sel
fprintf('YoY Revenue Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))

%% Debt to Assets
osel=odebtasset>filt_debtasset & ~isnan(odebtasset);
sel=debtasset>filt_debtasset | isnan(debtasset);
high_ps_filter_sel
fprintf('Debt to Assets Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))


%% Earnings
osel=oeps<filt_eps & ~isnan(oeps);
sel=eps<filt_eps | isnan(eps);
high_ps_filter_sel
fprintf('Earnings Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))


%% Earnings YoY
osel=oepsyoy<filt_epsyoy & ~isnan(oepsyoy);
sel=epsyoy<filt_epsyoy | isnan(epsyoy);
high_ps_filter_sel
fprintf('YoY Earnings Filtered %d Companies\n',oncompanies-sum(osel))
fprintf('Remaining Companies: %d\n\n',sum(sel))

