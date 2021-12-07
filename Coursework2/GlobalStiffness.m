function StiffnessMatrix = GlobalStiffness(StiffnessMatrix,D,Lamda,Mesh)

for idx = 1: length(StiffnessMatrix) -1
  
    % Generate diffusion local elements and populate global matrix
    LocalMatrix = LaplaceElemMatrix(D,idx,Mesh);    
    StiffnessMatrix(idx:idx+1,idx:idx+1) = StiffnessMatrix(idx:idx+1,idx:idx+1) + LocalMatrix ;
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrix(Lamda,idx,Mesh);
    StiffnessMatrix(idx:idx+1,idx:idx+1) = StiffnessMatrix(idx:idx+1,idx:idx+1) - LocalMatrix ;
      
end