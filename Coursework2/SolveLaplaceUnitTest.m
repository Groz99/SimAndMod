
%% Test 1: test that 1st Dirichlet boundary condition is implemented correctly
% % 
tol = 1e-14;

D = 1; %Diffusion Coefficient
Lamda = -9; %Reaction Coefficient
NNodes = 5;
BC0 = 'DL';
BC0Val = 0;
BC1 = 'DL';
BC1Val = 1;

[Solution, Domain] = SolveLaplace(D,Lamda,NNodes,BC0,BC0Val,BC1,BC1Val);

assert(abs(Solution(1) - BC0Val)< tol)

%% Test 2: test that 2nd Dirichlet boundary condition is implemented correctly
% % 
tol = 1e-14;

D = 1; %Diffusion Coefficient
Lamda = -9; %Reaction Coefficient
NNodes = 5;
BC0 = 'DL';
BC0Val = 0;
BC1 = 'DL';
BC1Val = 1;

[Solution, Domain] = SolveLaplace(D,Lamda,NNodes,BC0,BC0Val,BC1,BC1Val);

assert(abs(Solution(end) - BC1Val)< tol)



%% Test 3: test that a Von Neumann BC is implemented correctly by verifying the gradient for a linear system
% % 
tol = 1e-14;

D = 1; %Diffusion Coefficient
Lamda = 0; %Reaction Coefficient
NNodes = 5;
BC0 = 'VN';
BC0Val = 9.4;
BC1 = 'DL';
BC1Val = 0;

[Solution, Domain] = SolveLaplace(D,Lamda,NNodes,BC0,BC0Val,BC1,BC1Val);

grad = (Solution(end) - Solution(1))/(Domain(end) - Domain(1));

assert(abs(grad - BC0Val) < tol) 

%% Test 4: test that with a very fine mesh that node points are "Close" to a known analytical solution
% % Is it neccesary to use an L2 Norm method to verify this more robustly? 

%Have to reduce tolerance as we are dealing with truncation errors that are
%orders of magnitude larger than rounding errors
tol = 1e-3;

D = 1; %Diffusion Coefficient
Lamda = -9; %Reaction Coefficient
NNodes = 101; %Convenient for matching to 100 point domain
BC0 = 'DL';
BC0Val = 0;
BC1 = 'DL';
BC1Val = 1;

%FEM solution
[Solution, Domain] = SolveLaplace(D,Lamda,NNodes,BC0,BC0Val,BC1,BC1Val);

%Analytical solution
Exp = exp(1);
P = linspace(0,1,101);
Ce = (Exp^3)/((Exp^6)-1) * (Exp.^(3*P) - Exp.^(-3*P));

Error = Ce - Solution';
TotalError = sum(Error);

assert(abs(TotalError) < tol) 
close all % Close graphs that are usually plotted