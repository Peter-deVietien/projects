t=readtable('2020_nyt_PA_votes_data.csv','format','%D%d%d%d%d%d%d%f');

times=t.TimestampUTC;
t_votes=t.Trump;
b_votes=t.Biden;
t_delta=t.TrumpDelta;
b_delta=t.BidenDelta;
net_delta=double(t.NetChange);