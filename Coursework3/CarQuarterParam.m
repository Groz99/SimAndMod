%script to set the parameters for the quarter car model

%Base
M1 = 500; %Car
M2 = 20; % WHeel
Kt = 14e4;
Ks = 2e4;
Cs = 1200;

%VERIF2
%Ks = Ks * 100;
%Cs = Cs * 1000;

%VERIF3
%M2 = 0.02;
%Kt = Kt*100;
%Cs = Cs/10
%Cs = 0;


% NONELINEAR
Ccomp = 600;
Cext = 1200;
%Ccomp = 600000;
%Cext = 1200000;
x0 = 0.2;
Ks2 = 20*Ks;

%ANGULAR EFECTS
I = 600;
a = 1.25;

b = 1.4;
%a = b ; %Equal to COM for debug

%Road 
Lamda = 1;
speedmph = 70;
speed = speedmph * 1000 * (1.609/3600);