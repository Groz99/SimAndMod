%Script to call the analytical solution function provided over a range of
%times for understanding and comprehensive testing

% Arbitrary solution of x - making this a vector will produce a soln
% surface
clear all

x  = 0.5 % domain is 0<x<1;
tmax = 10 % run for 10 seconds
dt = 0.1 % Time step of 0.1 seconds 
solnvec = zeros(1,tmax/dt); % init soln vec
solnidx = 1

for t = 0 : dt : tmax
    solnvec(solnidx) = TransientAnalyticSoln(x,t); 
    solnidx = solnidx + 1;
end

taxis = 0 : dt : tmax;
plot(taxis,solnvec)
ylabel('solution')
xlabel('time')
