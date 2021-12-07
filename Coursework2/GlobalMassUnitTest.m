
%% Test 1: test symmetry of the matrix
% % Test that this matrix is symmetric
NElements = 10
NNodes = NElements + 1
msh = OneDimLinearMeshGen(0,1,NElements);
MassMatrix = zeros(NNodes,NNodes);
MassMatrix = GlobalMass(MassMatrix,msh);
tol = 1e-14;


msh = OneDimLinearMeshGen(0,1,10);

assert(abs(MassMatrix(1,1) - MassMatrix(end,end)) <= tol)

%% Test 2: test symmetry of the matrix
% % Test that diagonal summing is working as needed
NElements = 10
NNodes = NElements + 1
msh = OneDimLinearMeshGen(0,1,NElements);
MassMatrix = zeros(NNodes,NNodes);
MassMatrix = GlobalMass(MassMatrix,msh);
tol = 1e-14;


msh = OneDimLinearMeshGen(0,1,10);

assert(abs(MassMatrix(1,1) - 0.5* MassMatrix(2,2)) <= tol)
