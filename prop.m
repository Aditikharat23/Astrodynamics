function dstatedt = prop(t,state)

r = state(1:3);
vi = state(4:6);
mu  = 398600;
if t==2914
    th= 2.0633/1;
   a = -mu*r/(norm(r))^3 + [0,-th,0];
elseif t ==15435
   a = -mu*r/(norm(r))^3 + [0,1.4029,0];
else
a = -mu*r/(norm(r))^3; %row
end
dstatedt = [vi a] ;%Row
end
