%% Test 1 : Verify that stiffness matrix is correctly combining reaction 
% and diffusion terms
% Note that these sub functions have already been verified separately
tol = 1e-14;
NElements = 10;
D = 2;
Lamda = -9;
eID = 1;
msh = OneDimLinearMeshGen(0,1,NElements);
StiffnessMat = zeros(NElements);

LaplaceMat = LaplaceElemMatrix(D,eID,msh);
ReactionMat = ReactionMatrix(Lamda,eID,msh);
StiffnessMat = GlobalStiffness(StiffnessMat,D,Lamda,msh);

assert(StiffnessMat(eID,eID) - (LaplaceMat(eID,eID) - ReactionMat(eID,eID)) <= tol)

%% Test 2 : Verify matrix symmetry 
% Note that these sub functions have already been verified separately
tol = 1e-14;
NElements = 10;
D = 2;
Lamda = -9;
msh = OneDimLinearMeshGen(0,1,NElements);
StiffnessMat = zeros(NElements);

StiffnessMat = GlobalStiffness(StiffnessMat,D,Lamda,msh);

assert(StiffnessMat(1,1) - StiffnessMat(end,end) <= tol)

%% Test 3 : Verify matrix diagonal pattern as shown in lectures
% Note that these sub functions have already been verified separately
tol = 1e-14;
NElements = 10;
D = 2;
Lamda = -9;
eID = 1;
msh = OneDimLinearMeshGen(0,1,NElements);
StiffnessMat = zeros(NElements);

StiffnessMat = GlobalStiffness(StiffnessMat,D,Lamda,msh);

assert(StiffnessMat(eID,eID) - 2*StiffnessMat(1,1) <= tol)