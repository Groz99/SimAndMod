%Similarities between diffusion and reaction local element matrices allow
%lots of the provided code to be reused here:

%% Test 1: test symmetry of the matrix
% % Test that this matrix is symmetric. This is the same verification as for the
% diffusion LEM's
tol = 1e-14;
eID=1; %element ID

msh = OneDimLinearMeshGen(0,1,10);
elemat = LocalMassMatrix(eID,msh); 

assert(abs(elemat(1,2) - elemat(2,1)) <= tol)

%% Test 2: test 2 different elements of the same size produce same matrix
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element matrices calculated are the same. This is the 
%   same verification as for the diffusion LEM's
tol = 1e-14;
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat1 = LocalMassMatrix(eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

eID=2; %element ID

elemat2 = LocalMassMatrix(eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

diff = elemat1 - elemat2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 3: test that one matrix is evaluted correctly
% % Test that element 1 of the three element mesh problem described in the lectures
% % the element matrix is evaluated correctly. This uses the example shown
% % from tutorial sheet 3.
tol = 1e-14;
Lamda = 9; %Reaction coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,3);

elemat1 = LocalMassMatrix(eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

elemat2 = [ 1/9 0.5/9; 0.5/9 1/9];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 4: test that different sized elements in a mesh are evaluted correctly - element 1
% % Test that elements in a non-equally spaced mesh are evaluated correctly
tol = 1e-14;
Lamda = 6; %Reaction coefficient
eID=1; %element ID
msh = OneDimSimpleRefinedMeshGen(0,1,5);

elemat1 = LocalMassMatrix(eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

elemat2 = [ 1/6 0.5/6; 0.5/6 1/6];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 5: test that different sized elements in a mesh are evaluted correctly - element 4
% % Test that elements in a non-equally spaced mesh are evaluated correctly
tol = 1e-14;
Lamda = 48; %Reaction coefficient
eID=4; %element ID
msh = OneDimSimpleRefinedMeshGen(0,1,5);

elemat1 = LocalMassMatrix(eID,msh);%THIS IS THE FUNCTION YOU MUST WRITE

elemat2 = [ 1/48 0.5/48; 0.5/48 1/48];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)