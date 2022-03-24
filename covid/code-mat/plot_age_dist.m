cca
usa_age_dist

bar(pop_bins)

pop77=pop_bins;
pop69=pop_bins;

pop77(1:76)=0;

hold on
bar(pop77)
hold off