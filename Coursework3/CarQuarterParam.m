%script to set the parameters for the quarter car model

%Base
M1 = 500; %Car
M2 = 20; % WHeel
Kt = 14e4;
Ks = 2e4;

% NONELINEAR
Ccomp = 600;
Cext = 1200;
x0 = 0.2;
Ks2 = 20*Ks;

%ANGLE
I = 600;
a = 1.25;

b = 1.4;
b = 1.5;
a = b ; %Equal to COM for debug

%Road 
Lamda = 1;
speed = 2;