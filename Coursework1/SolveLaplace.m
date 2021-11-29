%clear all % Shouldnt need this as all matrices are initialised 

% Set boundary conditions

%VN - Gradient

% At x = 0
dcdx = 2;

%Dirichlet - Fixed
% At x = 1
% At x = 1, must zero last node and then set diagonal to 1
% Hence, C = 0 in solution vector
c = 0;
%c = 1;

%Material parameteres
D = 1; % D = 1 in this case
%Lamda = 6;
Lamda = 0; % For this excercise there is no Lamda
%Create global mesh
xmin = 0;
xmax = 1;
NNodes = 5;


Mesh = OneDimLinearMeshGen(xmin,xmax,NNodes); % Local element number nodes same as global?? ;
%Size of global mesh effects local element values due to varying J scaling

GMatrix = zeros(NNodes,NNodes);
SourceVector = zeros(NNodes,1); % Source term is all 0s for laplacian eq.

%Form local element matrices as struct

for idx = 1: length(GMatrix) -1
    
    % Generate diffusion local elements and populate global matrix
    LocalMatrix = LaplaceElemMatrix(D,idx,Mesh);    
    GMatrix(idx:idx+1,idx:idx+1) = LocalMatrix + GMatrix(idx:idx+1,idx:idx+1);
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrix(Lamda,idx,Mesh);
    GMatrix(idx:idx+1,idx:idx+1) = LocalMatrix + GMatrix(idx:idx+1,idx:idx+1)
    
    
end

%for
    %source terms
%end


%Enforce BCs, VN first

% VN
% Specifically for dc/dx = 2 at x =0
% Goes to -2 in source vector i.e. this sets the gradient of the solution
SourceVector(1) = SourceVector(1) + -dcdx % Need to add for VN 
%GMatrix(1) = 1;

% Dirichlet
% Specifically for c = 0 at at x = 1
GMatrix(end,:) = 0;
GMatrix(end) = 1;

% FUDGE
GMatrix(1,:) = 0;
GMatrix(1,1) = 1;

%Is pre-initialised as 0 but zero for maths clarity
SourceVector(end) = c; % c is 0 in this case % Need for overwrite for DC




SolutionVector = GMatrix\SourceVector

x = linspace(xmin,xmax,length(SolutionVector))
y = SolutionVector

plot(x,y)



    
    
