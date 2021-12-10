%Function to assemble a global stiffness matrix with diffusion and
%reaction local element components calculated using GQ. Modified for
%application to the skin problem 

%Takes:
%StiffnessMatrix - Initialised to zeros, (N x N float) 
%eID - Element number (int)
%msh - Enhanced mesh data structure, generated using OneDimLinearMeshGen.m 
% and enhanced with EnhanceMeshData(struct)

%Outputs:
%StiffnessMatrix - (N x N float)

function StiffnessMatrix = GlobalStiffnessGQ_p2(StiffnessMatrix,Mesh)

%Determine the size of the local elements being operated upon
ScalingMat = LaplaceElemMatrixGQ_p2(1,Mesh);
Matrixscaling = length(ScalingMat)-1;
%Extract mesh characteristics
NElements = Mesh.ne;
NNodes = Mesh.ngn;
eID = 1;
for idx = 1:2:NNodes - Matrixscaling
  
    % Generate diffusion local elements and populate global matrix   
    LocalMatrix = LaplaceElemMatrixGQ_p2(eID,Mesh);   
    
    Matrixscaling = length(LocalMatrix)-1; %Scale the distance the LEM is 
                                           %added over based on its
                                           %dimensions
    
    StiffnessMatrix(idx:idx+Matrixscaling,idx:idx+Matrixscaling) =...
    StiffnessMatrix(idx:idx+Matrixscaling,idx:idx+Matrixscaling) + LocalMatrix ;
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrixGQ_p2(eID,Mesh);
    
    Matrixscaling = length(LocalMatrix)-1;
     
    StiffnessMatrix(idx:idx+Matrixscaling,idx:idx+Matrixscaling) =...
    StiffnessMatrix(idx:idx+Matrixscaling,idx:idx+Matrixscaling) - LocalMatrix ; 

    eID = eID + 1; %Call correct element for material parameters etc.
end