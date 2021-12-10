%Function to solve Laplace's equation when applied to a specific hysical problem of
%modelling heat transfer through skin tissue. Here Lamda and D are 
%calculated based on the material properties of the skin at each location
%in the mesh

%Takes the following arguments:
%D - Diffusion Co-efficient (Float)
%Lamda - Reaction Co-efficient (Float)
%NNodes - Number of nodes in global mesh (NElements = NNodes - 1) (Int)
%BC0 - Type of node 0 boundary condition, 'DL' for Dirichlet or 'VN' for Von
%Nuemman (Str)
%BC0Val - Value of c or dc/dx for node 0 boundary condition (Float)
%BC1 - Node 1 boundary condition, same format as BC0
%BC1Val - Value of c or dx/dx for node 1 boundary condition (Float)
%DM - Differencing Method, can take 'CN','FE','BE' (String)
%xloc - The location in the skin that the degree of burning is to be
%       evaluated, must be in range 0<xloc<0.01 (float)

%Outputs:
%C - N x N solution matrix in space and time (float)
%Domain - Values of x that map to C (float)
%TDomain - Values of t that map to C (float)
%GammaTotal - The total burn damage suffered (float)


%E.g.
%[C, Domain, TDomain] = SolveLaplaceTransient_GQ_p2(52,100,'DL',393.75,'DL',310.15,'CN',0.05)

 
function [C, Domain, TDomain, GammaTotal] = SolveLaplaceTransient_GQ_p2_1(NElements,NTsteps,BC0,BC0Val,BC1,BC1Val,DM,xloc)
 
%Set domain for range of distance in skin
xmin = 0;
xmax = 0.01;

%Set time scheme
tmax = 50;
dt = tmax/NTsteps;

%Set initial temperature condition to standard internal body temperature
Tstart = 310.15;

%Define theta dependent upon the difference method selected
if DM == 'CN'
    theta = 1;
elseif DM == 'FE'
    theta = 0;
elseif DM == 'BE'
    theta = 0.5;

end



%Initialise mesh
NNodes = 2*NElements + 1;
Mesh = OneDimLinearMeshGenGQ(xmin,xmax,NElements); 

%Add material parameters to mesh data structure
Mesh = EnhanceMeshData(Mesh,0,1);

%Run the model with the assumption of 0 blood flow if desired
%Mesh.G(:) = 0;

%Initialise neccesary matrices
StiffnessMatrix = zeros(NNodes,NNodes);
MassMatrix = zeros(NNodes,NNodes);
GlobalMatrix = zeros(NNodes); % Combination of the two
GlobalVector = zeros(NNodes,1); 
SourceVector = zeros(NNodes,1);
GammaT = zeros(NTsteps,1);
C = zeros(NNodes,NTsteps);

% Need two solutionvectors to implement timestepping
Ccurrent = zeros(NNodes,1) + Tstart; %Define initial conditions here 
Cnext = zeros(NNodes,1);   

Fcurrent = zeros(NNodes,1); % Initialise source term
Fnext = Fcurrent;

NBCcurrent = zeros(NNodes,1); %Capability for timevariant Von-Neumman
NBCnext = NBCcurrent;         %Boundary conditions  

%Step through time
for idxt = 1 : NTsteps
    
    %Re-initialise matrices
    StiffnessMatrix = zeros(NNodes);
    MassMatrix = zeros(NNodes);
    GlobalMatrix = zeros(NNodes);
    GlobalVector = zeros(NNodes,1);
    
    % Populate global stiffness matrix
    StiffnessMatrix = GlobalStiffnessGQ_p2(StiffnessMatrix,Mesh);
    % Populate a global mass matrix 
    MassMatrix = GlobalMassGQ(MassMatrix,Mesh); 
    
    % Combine into an overall global matrix to constitute the LHS equation
    GlobalMatrix = MassMatrix + theta*dt*StiffnessMatrix;
      
    %Assemble the global source vector
    Fnext = GlobalSourceGQ_p2(SourceVector,Mesh);
    
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
    
    Cnext = GlobalMatrix\CombinedRHS;
    C(:,idxt) = Cnext;
    
    %Assess if a burn may occur
    %Need to interpolate within nodes for high accuracy assessment
    Cinterp = QuadInterpolate(Cnext,Mesh,xloc);
    
    %If a burn may occur add its damage contribution to the integral
    if Cinterp > 317.15
        GammaT(idxt) = 2*10^98*exp(-12017/(Cinterp - 273.15)); 
    end    
    
    %Step time variant terms
    Ccurrent = Cnext;
    Fcurrent = Fnext; 

end

%Use inbuilt function to integrate GammaT burn damage 
%and output to terminal
GammaTotal = trapz(GammaT) * dt;
disp(['Burn damage of ' num2str(GammaTotal)])

%Output relevant domains for plotting, saving and analysis
Domain = linspace(xmin,xmax,NNodes);
TDomain = linspace(0,tmax,NTsteps); 

end

