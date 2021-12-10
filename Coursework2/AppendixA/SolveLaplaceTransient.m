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
%DM - Differencing Method, can take 'CN','FE','BE' (String)
%E.g. SolveLaplaceTransient(1,-9,5,100,'DL',0,'DL',1,'CN')

%Outputs:
%C - N x N solution matrix in space and time (Float)
%Domain - Values of x that map to C (Float)
%TDomain - Values of t that map to C (Float)

%This is the start of the transient solution and has been extensively
%modified from the previously submitted "SolveLaplace.m"
%
%Note that the domain is currently hardcoded from x = 0 to x = 1
 
function [C, Domain, TDomain] = SolveLaplaceTransient(D,Lamda,NNodes,NTsteps,BC0,BC0Val,BC1,BC1Val,DM)
 
%Set domain
xmin = 0;
xmax = 1;
 
%Set time scheme
tmax = 1;
dt = tmax/NTsteps;

%Define theta dependent upon the difference method selected
if DM == 'CN'
    theta = 1;
elseif DM == 'FE'
    theta = 0;
elseif DM == 'BE'
    theta = 0.5;
end

% Initialise mesh
Mesh = OneDimLinearMeshGen(xmin,xmax,NNodes-1); % Elements will also be N-1 ;
%Size of global mesh effects local element values due to varying J scaling
 
%Initialise matrices 
StiffnessMatrix = zeros(NNodes,NNodes);
MassMatrix = zeros(NNodes,NNodes);
GlobalMatrix = zeros(NNodes,NNodes); 
GlobalVector = zeros(NNodes,1); 
SourceVector = zeros(NNodes,1); % Source term is all 0s here
C = zeros(NNodes,NTsteps);

% Need two solutionvectors to implement timestepping
Ccurrent = zeros(NNodes,1); %Define initial conditions here 
Cnext = zeros(NNodes,1);   

Fcurrent = zeros(NNodes,1); %Capability for timevariant source term
Fnext = Fcurrent; 

NBCcurrent = zeros(NNodes,1); %Capability for timevariant Von-Neumman
NBCnext = NBCcurrent;         %Boundary conditions

% Populate global stiffness matrix
StiffnessMatrix = GlobalStiffness(StiffnessMatrix,D,Lamda,Mesh);

% Populate a global mass matrix 
MassMatrix = GlobalMass(MassMatrix,Mesh); 

% Combine into an overall global matrix to constitute the LHS equation
GlobalMatrix = MassMatrix + theta*dt*StiffnessMatrix;

for idxt = 1 : NTsteps
    % Assemble the global source vector
    Fnext = GlobalSource(SourceVector,Mesh);   
    % Construct Previous solution, source term and boundary RHS
    PrevSolution = (MassMatrix - (1-theta)*dt*StiffnessMatrix)*Ccurrent;
    SourceNew = dt*theta*(Fnext+NBCnext);
    SourceCurrent = dt*(1-theta)*(Fcurrent + NBCcurrent);
    CombinedRHS = PrevSolution + SourceNew + SourceCurrent;   
    
    %Enforce boundary conditions at node 0
    switch BC0    
        case 'VN'
            SourceVector(1) = SourceVector(1) + -BC0Val; % Need to add for VN    
        case 'DL'
            GlobalMatrix(1,:) = 0;
            GlobalMatrix(1,1) = 1;
            CombinedRHS(1) = BC0Val;     
    end
    
    %Enforce boundary conditions at node 1
    switch BC1   
        case 'VN'
            SourceVector(end) = SourceVector(end) + -BC1Val; % Need to add for VN        
        case 'DL'
            GlobalMatrix(end,:) = 0;
            GlobalMatrix(end) = 1;
            CombinedRHS(end) = BC1Val;
    end  
 
    Cnext = GlobalMatrix\CombinedRHS; % Solve equation for this timestep
    %write to output matrix for plotting, saving and analysis
    C(:,idxt) = Cnext;
    
    %Step time variant terms
    Ccurrent = Cnext;
    Fcurrent = Fnext; 
    NBCcurrent = NBCnext;
   
end

%Output relevant domains for plotting, saving and analysis
Domain = linspace(xmin,xmax,NNodes);
TDomain = linspace(0,tmax,NTsteps); 

end
