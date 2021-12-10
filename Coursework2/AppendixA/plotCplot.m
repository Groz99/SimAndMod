%Script to examine output of SolveLaplaceTransient
close all
clear all
Nt = 100;
NElements = 52;
NNodes = NElements + 1

[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,NElements,Nt,'DL',0,'DL',1,'CN');
%[Cplot,Domain,TDomain] = SolveLaplaceTransient_GQ_p2(NElements,Nt,'DL',0,'DL',1,'CN');
% NEED D = 1, Lamda, F =1, solution is 0 at x= 0 and 1 at x = 1


tmax = 1;
dt = tmax/Nt;

figure
hold on

%Plot single
x = 0.4;
plot(TDomain,Cplot(round(x*NNodes),:),'LineWidth',1)


%for idxt = 1 : length(Cplot(1,:))
%    plot(Domain,Cplot(:,idxt))
%end


%EACH SLICE IS A T 
%for idx = 1 : length(Cplot(:,1))
%    plot(Cplot(:,idx),Domain)
%end

ylabel('C(x,t)')
xlabel('t')


%plot analyitical soln.
%figure 
 % let t = 0.05
npoints = length(TDomain)

t = linspace(0,max(TDomain),npoints);

for idx = 1 : npoints 
    ansln(idx) = TransientAnalyticSoln(x,t(idx));
end

plot(TDomain,ansln,'LineWidth',1)
ylabel('C(x)')
xlabel('x')
legend('Numerical','Analytical')
%{
for idx = 1 : length(Cplot(:,1))
    for idt = 1 : length(Cplot(1,:))     
    ansln(idx,idt) = TransientAnalyticSoln(Domain(idx),idt*dt);
    end
end
hold on

plot(ansln(:,1),Domain)
plot(ansln(:,2),Domain)
plot(ansln(:,3),Domain)
plot(ansln(:,4),Domain)
plot(ansln(:,5),Domain)
ylabel('x')
xlabel('t')

%}
%{
plot(Domain,ansln(:,1))
plot(Domain,ansln(:,2))
plot(Domain,ansln(:,3))
plot(Domain,ansln(:,4))
plot(Domain,ansln(:,5))
%}