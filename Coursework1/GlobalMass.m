function MassMatrix = GlobalMass(MassMatrix,Mesh)

for idx = 1: length(MassMatrix) -1
  
    % Generate mass local elements and populate global matrix
    LocalMatrix = LocalMassMatrix(idx,Mesh);    
    MassMatrix(idx:idx+1,idx:idx+1) = MassMatrix(idx:idx+1,idx:idx+1) + LocalMatrix ;

end