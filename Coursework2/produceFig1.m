%Script to produce figure that demontrates succseful diffusion eq
close all
clear all
Nt = 100;
NNodes = 10;
[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NNodes,Nt,'DL',0,'DL',1,'BE');
% NEED D = 1, Lamda, F =1, solution is 0 at x= 0 and 1 at x = 1
tmax = 1;
dt = tmax/Nt;
figure

hold on

%Plot each line
t = 0.05;
idxt = t/dt;
plot(Domain,Cplot(:,idxt),'LineWidth',2)

t = 0.1;
idxt = t/dt;
plot(Domain,Cplot(:,idxt),'LineWidth',2)

t = 0.3;
idxt = t/dt;
plot(Domain,Cplot(:,idxt),'LineWidth',2)

t = 1;
idxt = t/dt;
plot(Domain,Cplot(:,idxt),'LineWidth',2)

ylabel('C(x,t)')
xlabel('x')
legend('T = 0.05', 'T = 0.1', 'T = 0.3', 'T = 1')
