%% Test 1: Test Matrix Geometry
% % Test that this matrix is 1 Dimensional
NElements = 10;

msh = OneDimLinearMeshGen(0,1,NElements);
SourceVector = zeros(NElements,1);
SourceVector = GlobalSource(SourceVector,msh);

assert(length(SourceVector(1,:)) == 1);

%% Test 2: Test Matrix Geometry
% % Test that the source vector follows pattern shown in lectures
tol = 1e-14;
NElements = 10;

msh = OneDimLinearMeshGen(0,1,NElements );
SourceVector = zeros(NElements);
SourceVector = GlobalSource(SourceVector,msh);

assert(SourceVector(1) - SourceVector(end) <= tol)

%% Test 3: Test Matrix Geometry
% % Test that the source vector follows pattern shown in lectures
tol = 1e-14;
NElements = 10;

msh = OneDimLinearMeshGen(0,1,NElements );
SourceVector = zeros(NElements);
SourceVector = GlobalSource(SourceVector,msh);

assert(SourceVector(2) - SourceVector(end-1) <= tol)