close all
clear all
NNodes = 10 % MUST BE LESS THAN 10 FOR FE STABILITY at 1000 Tsteps, Major osc starts at 15
NTsteps = 1000

figure
hold on

%NB Boundary conditions apply in space only

%CRANK NICHOLSON
[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NNodes,NTsteps,'DL',0,'DL',1,'CN');
%Cplot(:,1) = []
plot(TDomain,Cplot(8,:))

%FORWARD EULER
[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NNodes,NTsteps,'DL',0,'DL',1,'FE');
%Cplot(1,:) = []
plot(TDomain,Cplot(8,:))

%BACKWARDS EULER
[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NNodes,NTsteps,'DL',0,'DL',1,'BE');
%Cplot(1,:) = []
plot(TDomain,Cplot(8,:))


%Plot Analytical solution
npoints = length(TDomain)
xpos = 0.8
for idx = 1 : npoints 
    ansln(idx) = TransientAnalyticSoln(xpos,TDomain(idx))
end
%ansln(1) = []
plot(TDomain,ansln)
ylabel('C(x)')
xlabel('t')
legend('Crank Nicholson','Forward Euler', 'Backwards Euler','Numerical')