%Function to assemble a global stiffness matrix using diffusion and
%reaction local element components

%Takes:
%StiffnessMatrix - Initialised to zeros, (N x N float) 
%D - Diffusion coefficient (float)
%Lamda - Reaction coefficient (float)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%OneDimSimpleRefinedMeshGen.m (struct)

%Outputs

function StiffnessMatrix = GlobalStiffness(StiffnessMatrix,D,Lamda,Mesh)

for idx = 1: length(StiffnessMatrix) -1
  
    % Generate diffusion local elements and populate global matrix
    LocalMatrix = LaplaceElemMatrix(D,idx,Mesh);    
    StiffnessMatrix(idx:idx+1,idx:idx+1) = StiffnessMatrix(idx:idx+1,idx:idx+1) + LocalMatrix ;
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrix(Lamda,idx,Mesh);
    StiffnessMatrix(idx:idx+1,idx:idx+1) = StiffnessMatrix(idx:idx+1,idx:idx+1) - LocalMatrix ;
      
end