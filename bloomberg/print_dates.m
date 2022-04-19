cca

t=datetime(1990,3,31);
% for i=1:132
%     fprintf('%s\n',datestr(t,'mm/dd/yyyy'));
%     t=t+calmonths(3);
%     t=eomdate(t);
% 
% end


for i=1:134
    fprintf('%sQ%d\n',datestr(t,'yyyy'),mod(i-1,4)+1);
    t=t+calmonths(3);
    t=eomdate(t);

end
