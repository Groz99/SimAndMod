function StiffnessMatrix = GlobalStiffnessGQ(StiffnessMatrix,D,Lamda,Mesh)

ScalingMat = LaplaceElemMatrixGQ(D,1,Mesh);
Matrixscaling = length(ScalingMat)-1;
NElements = Mesh.ne;
NNodes = Mesh.ngn;
eID = 1;
for idx = 1:2:NNodes - Matrixscaling
  
    % Generate diffusion local elements and populate global matrix
    %eID = (idx-1)/2
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