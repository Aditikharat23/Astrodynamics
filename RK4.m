function [t_track,state_track] = RK4(state,h,tend) 
%State input and output is a row vector
t_track(1)=0;
state_track(1,:)= state;
t = 0;
iterations = floor(tend/h) +1;
for i  = 1:iterations
    
k1 = h*prop(t,state);
k2 = h*prop(t,state + 0.5*k1);
k3 = h*prop(t,state + 0.5*k2);
k4 = h*prop(t,state+ k3);


state = state + (k1+2*k2+2*k3+k4)/6 ;

state_track(i+1,:) = state;
t = t+h;
t_track(end+1) = t;
end
end

