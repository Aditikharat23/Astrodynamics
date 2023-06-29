clear all
close all

%% PART 1: Defining the parameters
r1 = 7000;%[km] initial parking orbit
r2 = 30000;%[km] final circular orbit
mu  = 398600;
% Paramters of the transfer orbit
a  = (r1+r2)/2;
e = 1 - (r1/a);
% Delta v
v1a = sqrt(mu/r1);% [KM/S] Velocity at point A due to initial circular orbit
v2a = sqrt((2*mu/r1)-(mu/a)); %[km/s] velocity at pt A due to trasfer orbit

delvA = v2a - v1a;

v2b = sqrt((2*mu/r2)-(mu/a)); %[km/s] velocity at pt B due to trasfer orbit
v3b = sqrt(mu/r2);% [KM/S] Velocity at point B due to final circular orbit
delvB = v3b-v2b;
%% 

v1 = sqrt(mu/r1);
T1 = 2*pi*sqrt(r1^3/mu); %Time period of orbit 1
T2 = 2*pi*sqrt(a^3/mu);
T3 = 2*pi*sqrt(r2^3/mu);
%Time for first delva
t1   = T1/2;
%Time for second delvb
t2  = t1 + (T2/2);
%% 

[t,state] = RK4([r1,0,0,0,v1,0],1,(t2+T3)) ;
% figure(1)
% plot3(state(:,1),state(:,2),state(:,3));


%% PART 2 : REFERENCE ORBIT SIMULATIONS
%Reference circular orbit
th = linspace(0,2*pi);
%Initial orbit
x1 = r1*cos(th);
y1 = r1*sin(th);
%Final orbit
x2 = r2*cos(th);
y2 = r2*sin(th);

%Reference elliptical orbit with one center at earth 
b = a*sqrt(1-e^2);
x3 = (a-r1)+a*cos(th);
y3  = b*sin(th);

x = state(:,1);
y = state(:,2);
f1 = figure(1);
f1.Position = [0,f1.Position(2:4)];%%Not sure??
clf
hold on
plot(x1,y1,':',x2,y2,':',x3,y3,':')
hold on 
plot(-r1,0,'Marker','o','MarkerFaceColor','r')
hold on
plot(r2,0,'Marker','o','MarkerFaceColor','r')
title('Hohmann Transfer')
hold on 
axis equal

orbit = plot(x(1),y(1),'b.','MarkerSize',20);
orbit1 = plot(x(1),y(1),'b');
hold off
set(gca,'Xlim',[-max(x)-2000,max(abs(x))+2000],'YLim',[-max(abs(y))-2000,max(abs(y))+2000],'Xtick',[],'YTick',[]);
%Plottig the reference orbits
% plot(x1,y1,':',x2,y2,':',x3,y3,':')
% hold on 
% plot(-r1,0,'Marker','o','MarkerFaceColor','b')
% hold on
% plot(r2,0,'Marker','o','MarkerFaceColor','r')
% hold on 
for i  = 2:length(state)
    if i==2 
        pause(5);
    end
 set(orbit,'XData',x(i),'YData',y(i));
 set(orbit1,'XData',x(1:i),'YData',y(1:i));
    pause(10^-10);
end

% plot(state(:,1),state(:,2))
% legend('Initial orbit',"Final Orbit",'Transfer orbit','A','B','Thrust orbit')
% axis equal
%%  



