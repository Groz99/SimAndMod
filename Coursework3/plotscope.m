

yaxis = Sfront10{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
figure
%plot(xaxis,yaxis,'m');
plot(xaxis,yaxis)
xlabel('Time')
ylabel('Displacement')
%set(gca,'Color','k')
%ax = gca;
%ax.GridColor = ['w'];  % [R, G, B]
grid on


%ylabel('Force/Displacement')
%yaxis = WheelR{1}.Values.Data;
%xaxis = linspace(0,10,length(yaxis));
%hold on
%plot(xaxis,yaxis,'y');
%legend('\color{white} Road','\color{white} Wheel')
figure
hold on
yaxis = Sfront20{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront30{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront40{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront50{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront60{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront70{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

yaxis = Sfront80{1}.Values.Data;
xaxis = linspace(0,10,length(yaxis));
plot(xaxis,yaxis)

legend('10','20','30','40','50','60','70','80')