%Script to examine output of SolveLaplaceTransient
close all
clear all

[Cplot,Domain,TDomain] = SolveLaplaceTransient(1,0,10,1000,'DL',0,'DL',1,'CN');
% NEED D = 1, Lamda, F =1, solution is 0 at x= 0 and 1 at x = 1


tmax = 1;
dt = 0.01;
close all
figure
hold on

%Plot single
t = 0.1;
idxt = t/dt;
plot(Domain,Cplot(:,idxt))


%for idxt = 1 : length(Cplot(1,:))
%    plot(Domain,Cplot(:,idxt))
%end


%EACH SLICE IS A T 
%for idx = 1 : length(Cplot(:,1))
%    plot(Cplot(:,idx),Domain)
%end

ylabel('C(x,t)')
xlabel('x')


%plot analyitical soln.
%figure 
t = 0.1; % let t = 0.05
npoints = length(Domain)
xpos = linspace(0,1,npoints)


for idx = 1 : npoints 
    ansln(idx) = TransientAnalyticSoln(xpos(idx),t)
end

plot(Domain,ansln)
ylabel('C(x)')
xlabel('x')
legend('Analytical','Numerical')
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