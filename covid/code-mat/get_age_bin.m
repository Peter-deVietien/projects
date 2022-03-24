usa_age_dist
%age_bin=zeros(sum(pop_bins),1);
age_bin=[];

for i = 1:numel(pop_bins)
    ind=sum(age_bin>0) + 1;
    age_bin(ind:ind+pop_bins(i))=i;
end

