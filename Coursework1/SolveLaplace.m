%Function to solve Laplace's equation for given parameters of diffusion and
%reaction coefficients. As a Laplacian problem the source terms are 0.
%
%Takes the following arguments:
%
%D - Diffusion Co-efficient (Float)
%Lamda - Reaction Co-efficient (Float)
%NNodes - Number of nodes in global mesh (NElements = NNodes - 1) (Int)
%BC0 - Type of node 0 boundary condition, 'DL' for Dirichlet or 'VN' for Von
%Nuemman (Str)
%BC0Val - Value of c or dc/dx for node 0 boundary condition (Float)
%BC1 - Node 1 boundary condition, same format as BC0
%BC1Val - Value of c or dx/dx for node 1 boundary condition (Float)
%
%The solution is plotted against a known analytical solution for:
%SolveLaplace(1,-9,N,'DL',0,'DL',1) - Any positive integer N. 
%E.g. SolveLaplace(1,-9,5,'DL',0,'DL',1)
%Note that the domain is currently hardcoded from x = 0 to x = 1

function [SolutionVector, Domain] = SolveLaplace(D,Lamda,NNodes,BC0,BC0Val,BC1,BC1Val)

%Set domain
xmin = 0;
xmax = 1;

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


%Form source vector - Is there a more efficient method for this? 
for idx = 1 : length(GMatrix)
    if idx == 1
        SourceVector(idx) = SourceVector(idx) * Mesh.elem(idx).J;
    elseif idx == length(GMatrix - 1)
            SourceVector(idx) = SourceVector(idx) * Mesh.elem(idx-1).J;   
    else
        SourceVector(idx) = SourceVector(idx) * (Mesh.elem(idx-1).J + Mesh.elem(idx).J);
    end
    
 end


% I dont think that this structure will cause problems with overwriting 
% with Dirichlet boundary conditions, can you please confirm this? 

%Enforce boundary conditions at node 0
switch BC0
    
    case 'VN'
        
        % VN
        % Specifically for dc/dx = 2 at x =0
        % Goes to -2 in source vector i.e. this sets the gradient of the solution
        SourceVector(1) = SourceVector(1) + -BC0Val; % Need to add for VN    
    
    case 'DL'
        
        % Dirichlet
        % Specifically for c = 0 at at x = 1
        GMatrix(1,:) = 0;
        GMatrix(1,1) = 1;
        SourceVector(1) = BC0Val; % c is 0 in this case % Need for overwrite for DC

        
end

%Enforce boundary conditions at node 1
switch BC1
    
    case 'VN'
        
        % VN
        % Specifically for dc/dx = 2 at x =0
        % Goes to -2 in source vector i.e. this sets the gradient of the solution
        SourceVector(end) = SourceVector(end) + -BC1Val; % Need to add for VN 
        
        
    case 'DL'
        
         % Dirichlet
         % Specifically for c = 0 at at x = 1
         GMatrix(end,:) = 0;
         GMatrix(end) = 1;
         SourceVector(end) = BC1Val; % c is 0 in this case % Need for overwrite for DC
    
end

%Solve matrix using matlab inbuilt matrix division
SolutionVector = GMatrix\SourceVector;
Domain = linspace(xmin,xmax,length(SolutionVector));

%Plot FEM solution
plot(Domain, SolutionVector, 'c')
             
%Add parameters to plot

%Generate analytical solution to compare with FEM solution
E = exp(1);
P = linspace(0,1,100);
Ce = (E^3)/((E^6)-1) * (E.^(3*P) - E.^(-3*P));

%Plot analytical solution to compare with FEM solution
hold on
plot(P,Ce,'r')
