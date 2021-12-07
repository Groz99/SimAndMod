%Script to examine output of SolveLaplaceTransient
close all
clear all
NNodes = 14 % MUST BE LESS THAN 14 FOR FE STABILITY 14, Major osc starts at 15
NTsteps = 1000
[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NNodes,NTsteps,'DL',0,'DL',1,'FE');
% NEED D = 1, Lamda, F =1, solution is 0 at x= 0 and 1 at x = 1

% Forward Euler broken, CN and BE working - FE is unstable???

tmax = 1;
figure
hold on
%Domain = linspace(0,1,1000)
plot(TDomain,Cplot(8,:))

%Plot single
npoints = length(TDomain)
trange = linspace(0,tmax,npoints)
xpos = 0.8
for idx = 1 : npoints 
    ansln(idx) = TransientAnalyticSoln(xpos,trange(idx))
end
plot(TDomain,ansln)
ylabel('C(x)')
xlabel('x')
legend('Analytical','Numerical')