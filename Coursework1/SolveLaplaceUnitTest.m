
%% Test 1: test that 2 Dirichlet boundary conditions are implemented correctly
% % 
tol = 1e-14;
D = 2 % These are non factors
Lamda = 2; %diffusion coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat = ReactionMatrix(Lamda,eID,msh); %THIS IS THE FUNCTION YOU MUST WRITE

assert(abs(elemat(1,2) - elemat(2,1)) <= tol)

