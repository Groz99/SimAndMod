function MassMatrix = GlobalMassGQ(MassMatrix,Mesh)

TestMat = LocalMassMatrixGQ(1,Mesh);
Matrixscaling = length(TestMat)-1; % Generic, works any sized LEM
NElements = Mesh.ne;
NNodes = Mesh.ngn;
eID = 1;

for idx = 1 : 2 : NNodes-Matrixscaling
  
    % Generate mass local elements and populate global matrix
    
    LocalMatrix = LocalMassMatrixGQ(eID,Mesh);   
    
    
    MassMatrix(idx:idx + Matrixscaling,idx:idx + Matrixscaling) =...
    MassMatrix(idx:idx+ Matrixscaling,idx:idx + Matrixscaling) + LocalMatrix ;

    eID = eID + 1;
end