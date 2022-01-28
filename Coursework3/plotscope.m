
Tmax = 20;
yaxis = WheelS{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
figure
plot(xaxis,yaxis,'m');
%plot(xaxis,yaxis)
xlabel('Time (s)')
ylabel('Tyre Force (N)')
set(gca,'Color','k')
ax = gca;
ax.GridColor = ['w'];  % [R, G, B]
grid on


ylabel('Displacement')
yaxis = InputFront{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
hold on
plot(xaxis,yaxis,'y');
legend('\color{white} Front Wheel', '\color{white} Road')

%{
figure
hold on


yaxis = Sfront10{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront20{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront30{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront40{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront50{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront60{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront70{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront80{1}.Values.Data;
xaxis = linspace(0,Tmax,length(yaxis));
plot(xaxis,yaxis)

xlabel('Time (s)')
ylabel('Displacement (m)')
%legend('20','30','40','50','60','70','80')
legend('10','20','30','40','50','60','70','80')
%}