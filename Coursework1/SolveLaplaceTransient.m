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

%This is the start of the transient solution and has been extensively
%modified from SolveLaplace - original function has been retained for
%legacy verification

%The solution is plotted against a known analytical solution for:
%SolveLaplaceTransient(1,-9,N,'DL',0,'DL',1) - Any positive integer N. 
%E.g. SolveLaplaceTransient(1,-9,5,'DL',0,'DL',1,'CN')
%
%Note that the domain is currently hardcoded from x = 0 to x = 1
 
function [Cplot, Domain, TDomain] = SolveLaplaceTransient(D,Lamda,NNodes,NTsteps,BC0,BC0Val,BC1,BC1Val,DM)
 
%Set domain
xmin = 0;
xmax = 1;
 
%Set time scheme
%LET
tmax = 1;
%NTsteps = 100;
dt = tmax/NTsteps;
%t = 0:dt:tmax;

%Define theta dependent upon the difference method selected
if DM == 'CN'
    theta = 1;
elseif DM == 'FE'
    theta = 0;
elseif DM == 'BE'
    theta = 0.5;

end

% If lamda, D, mesh etc. are time invariant want a switch case to avoid
% re-computation when they are constant

%for t = 0:dt:tmax 

% Initialise mesh
% NEED: Material coeff, D, Lamda, and Source term
% NEED: Global Matrix, Global Mass Matrix, Globable Stiffness Matrix and
% NEED : Ccurrent and CNext
% Global Matrix
Mesh = OneDimLinearMeshGen(xmin,xmax,NNodes-1); % Elements will also be N-1 ;
%Size of global mesh effects local element values due to varying J scaling
 
StiffnessMatrix = zeros(NNodes,NNodes);
MassMatrix = zeros(NNodes,NNodes);
GlobalMatrix = zeros(NNodes,NNodes); % Combination of the two
GlobalVector = zeros(NNodes,1); 
SourceVector = zeros(NNodes,1); % Source term is all 0s for laplacian eq. % Global vector

SolutionVector = zeros(NNodes,1); % Need to initialise a solution vector now

% Need two solutionvectors, HAVE RETAINED ABOVE DURING DEV.
Ccurrent = zeros(NNodes,1); %Define initial conditions here 
Cnext = zeros(NNodes,1);   

Fcurrent = zeros(NNodes,1); %Define initial conditions here % Use mesh to                             %Include the variation of this source term
Fnext = Fcurrent; %Stepping source term  

NBCcurrent = zeros(NNodes,1);
NBCnext = NBCcurrent;

% DONE IN FOR LOOP FOR NOW %%%%%%
%These can be outside idxt loop
% Populate global stiffness matrix 
%StiffnessMatrix = GlobalStiffness(StiffnessMatrix,D,Lamda,Mesh);

% Populate a global mass matrix 
%MassMatrix = GlobalMass(MassMatrix,Mesh); %%%%%%

for idxt = 1 : NTsteps
    
    % Generic version within FOR loop %%%%%%%%
    StiffnessMatrix = zeros(NNodes,NNodes);
    MassMatrix = zeros(NNodes,NNodes);
    GlobalMatrix = zeros(NNodes,NNodes); % Combination of the two
    GlobalVector = zeros(NNodes,1); 
    % Populate global stiffness matrix
    StiffnessMatrix = GlobalStiffness(StiffnessMatrix,D,Lamda,Mesh);
    % Populate a global mass matrix 
    MassMatrix = GlobalMass(MassMatrix,Mesh); %%%%%%%%
    
    % Combine into an overall global matrix - LHS
    %GlobalMatrix = GlobalMatrix + MassMatrix + theta*dt*StiffnessMatrix;
    GlobalMatrix = MassMatrix + theta*dt*StiffnessMatrix;
    
    % Construct Previous solution, source term and boundary RHS
    PrevSolution = (MassMatrix - (1-theta)*dt*StiffnessMatrix)*Ccurrent;
    SourceNew = dt*theta*(Fnext+NBCnext);
    SourceCurrent = dt*(1-theta)*(Fcurrent + NBCcurrent);
    
    CombinedRHS = PrevSolution + SourceNew + SourceCurrent;   
    %Need to do in terms of time steps
    Fcurrent = GlobalSource(SourceVector,Mesh);
    Fnext = Fcurrent; % Time invariant in this case
    %Fnext = Source vec at time n+1

    % I dont think that this structure will cause problems with overwriting 
    % with Dirichlet boundary conditions, can you please confirm this? 

    %Enforce boundary conditions at node 0
    switch BC0    
        case 'VN'
            % NOT TRANSIENT
            % VN
            % Specifically for dc/dx = 2 at x =0
            % Goes to -2 in source vector i.e. this sets the gradient of the solution
            SourceVector(1) = SourceVector(1) + -BC0Val; % Need to add for VN    
        case 'DL'

            % Dirichlet
            % Specifically for c = 0 at at x = 1
            %GMatrix(1,:) = 0;
            GlobalMatrix(1,:) = 0;
            %GMatrix(1,1) = 1;
            GlobalMatrix(1,1) = 1;
            %SourceVector = BC0Val;
            CombinedRHS(1) = BC0Val; % c is 0 in this case % Need for overwrite for DC       
    end
    %Enforce boundary conditions at node 1
    switch BC1   
        case 'VN'
            % NOT TRANSIENT
            % VN
            % Specifically for dc/dx = 2 at x = 0
            % Goes to -2 in source vector i.e. this sets the gradient of the solution
            SourceVector(end) = SourceVector(end) + -BC1Val; % Need to add for VN        
        case 'DL'

            % Dirichlet
            % 
            %GMatrix(end,:) = 0;
            %GMatrix(end) = 1;
            GlobalMatrix(end,:) = 0;
            GlobalMatrix(end) = 1;
            %SourceVector(end) = BC1Val; % c is 0 in this case % Need for overwrite for DC
            CombinedRHS(end) = BC1Val;
    end  
    
    Cnext = GlobalMatrix\CombinedRHS;
    Cplot(:,idxt) = Cnext;
    Ccurrent = Cnext;

    %SolutionVector = SolutionVector + GMatrix\SourceVector; % Sum solution with previous timestep data

%TEST
%hold on
%Domain = linspace(xmin,xmax,length(SolutionVector));
%plot(Domain,Cplot(:,idxt))

end

Domain = linspace(xmin,xmax,NNodes);
TDomain = linspace(0,tmax,NTsteps); 

end


%{
%Plot FEM solution
plot(Domain, SolutionVector, 'b')
             
%Add parameters to plot
 
%Generate analytical solution to compare with FEM solution
E = exp(1);
P = linspace(0,1,100);
Ce = (E^3)/((E^6)-1) * (E.^(3*P) - E.^(-3*P));
 
%Plot analytical solution to compare with FEM solution
hold on
plot(P,Ce,'r')
%}