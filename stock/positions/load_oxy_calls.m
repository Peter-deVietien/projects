strikes=[14,15,16,17,18,20,22,23,25,27,30]';
jan21c=[30,30,60,40,100,305,240,500,30,75,410]';
jan21p=[.52,.45,.3707,.89,.21,.4989,1.2117,.0894,1.08,.96,.4566]';

feb21c=[5,100,0,0,0,0,0,0,0,0,0]';
feb21p=[.92,.40,0,0,0,0,0,0,0,0,0]';

may21c=[0,50,0,0,100,0,0,0,0,0,0]';
may21p=[0,1.875,0,0,0.79,0,0,0,0,0,0]';

jan22c=[0,0,0,30,0,20,0,0,0,20,50]';
jan22p=[0,0,0,1.4753,0,2.375,0,0,0,2.89,0.70]';

jan21c2=[0,0,0,0,0,60,0,0,120,0,300]';
jan21p2=[0,0,0,0,0,2.61,0,0,.8919,0,1.8558]';

jan21calls=[strikes,jan21c,jan21p];
jan21calls2=[strikes,jan21c2,jan21p2];
feb21calls=[strikes,feb21c,feb21p];
may21calls=[strikes,may21c,may21p];
jan22calls=[strikes,jan22c,jan22p];

contracts=[jan21c+jan21c2+feb21c+may21c+jan22c];
ppaid=[jan21c.*jan21p + jan21c2.*jan21p2 + ...
    feb21c.*feb21p + may21c.*may21p + jan22c.*jan22p]./contracts;

calls=[strikes,contracts,ppaid];
