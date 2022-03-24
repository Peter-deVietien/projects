strikes=[230,300]';
jan23c=[120,155]';
jan23p=[20.74,9.09]';

jan23calls=[strikes,jan23c,jan23p];

contracts=[jan23c];
ppaid=[jan23c.*jan23p]./contracts;

calls=[strikes,contracts,ppaid];
