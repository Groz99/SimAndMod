clear all

%Material parameteres
D = 1; % D = 1 in this case
%Lamda = 6;
Lamda = -9; % For this excercise there is no Lamda
%Create global mesh
xmin = 0;
xmax = 1;
NNodes = 5;


% Set boundary conditions

%VN - Gradient
%VN at boundary one
%BC0 = 'VN'
%dcdx0 = 2;

%VN at boundary two
%BC1 = 'VN'
%dcdx1 = 0;

%Dirichlet - Fixed

% At x = 1
% At x = 1, must zero last node and then set diagonal to 1
% Hence, C = 0 in solution vector

BC0 = 'DL'
c0 = 0;

BC1 = 'DL'
c1 = 1;

% Initialise mesh

Mesh = OneDimLinearMeshGen(xmin,xmax,NNodes-1); % Elements will also be N-1 ;
%Size of global mesh effects local element values due to varying J scaling

GMatrix = zeros(NNodes,NNodes);
SourceVector = zeros(NNodes,1); % Source term is all 0s for laplacian eq.

%Form local element matrices as struct

for idx = 1: length(GMatrix) -1
    
    % Generate diffusion local elements and populate global matrix
    LocalMatrix = LaplaceElemMatrix(D,idx,Mesh);    
    GMatrix(idx:idx+1,idx:idx+1) = GMatrix(idx:idx+1,idx:idx+1) + LocalMatrix ;
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrix(Lamda,idx,Mesh);
    GMatrix(idx:idx+1,idx:idx+1) = GMatrix(idx:idx+1,idx:idx+1) - LocalMatrix ;
    
    
end



%for
    %source terms
%end

%Enforce BCs, VN first
%Use switch case to enforce 


% I dont think that this structure will cause problems with overwriting 
% with Dirichlet boundary conditions, can you please confirm this? 
switch BC0
    
    case 'VN'
        
        % VN
        % Specifically for dc/dx = 2 at x =0
        % Goes to -2 in source vector i.e. this sets the gradient of the solution
        SourceVector(1) = SourceVector(1) + -dcdx0; % Need to add for VN    
    
    case 'DL'
        
        % Dirichlet
        % Specifically for c = 0 at at x = 1
        GMatrix(1,:) = 0;
        GMatrix(1,1) = 1;
        SourceVector(1) = c0; % c is 0 in this case % Need for overwrite for DC

        
end

switch BC1
    
    case 'VN'
        
        % VN
        % Specifically for dc/dx = 2 at x =0
        % Goes to -2 in source vector i.e. this sets the gradient of the solution
        SourceVector(end) = SourceVector(end) + -dcdx1; % Need to add for VN 
        
        
    case 'DL'
        
         % Dirichlet
         % Specifically for c = 0 at at x = 1
         GMatrix(end,:) = 0;
         GMatrix(end) = 1;
         SourceVector(end) = c1; % c is 0 in this case % Need for overwrite for DC
    
end

%{
% VN
% Specifically for dc/dx = 2 at x =0
% Goes to -2 in source vector i.e. this sets the gradient of the solution
SourceVector(1) = SourceVector(1) + -dcdx % Need to add for VN 


% Dirichlet
% Specifically for c = 0 at at x = 1
GMatrix(end,:) = 0;
GMatrix(end) = 1;
SourceVector(end) = c; % c is 0 in this case % Need for overwrite for DC
%}



SolutionVector = GMatrix\SourceVector;

x = linspace(xmin,xmax,length(SolutionVector));
y = SolutionVector;

plot(x,y,'b')
% Add parameters to plot


%verify against analytical soln
E = exp(1);
P = linspace(0,1,100);
Ce = (E^3)/((E^6)-1) * (E.^(3*P) - E.^(-3*P));
hold on
plot(P,Ce,'r')

    
    
