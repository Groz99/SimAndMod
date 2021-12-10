%Function to assemble a global mass matrix using Gaussian quadrature
%And quadratic basis functions
%Takes:
%MassMatrix - Initialised to zeros(N x N float)
%Mesh - Mesh data structure, , generated using OneDimLinearMeshGen.m or 
%OneDimSimpleRefinedMeshGen.m (struct)

%Outputs:
%MassMatrix - (N x N float)

function MassMatrix = GlobalMassGQ(MassMatrix,Mesh)

TestMat = LocalMassMatrixGQ(1,Mesh);
Matrixscaling = length(TestMat)-1; % Generic to LEM size/Basis functions
NElements = Mesh.ne;               % used
NNodes = Mesh.ngn;
eID = 1;

for idx = 1 : 2 : NNodes-Matrixscaling
  
    % Generate mass local elements and populate global matrix
    
    LocalMatrix = LocalMassMatrixGQ(eID,Mesh);   
    
    MassMatrix(idx:idx + Matrixscaling,idx:idx + Matrixscaling) =...
    MassMatrix(idx:idx+ Matrixscaling,idx:idx + Matrixscaling) + LocalMatrix ;

    eID = eID + 1;
    
end