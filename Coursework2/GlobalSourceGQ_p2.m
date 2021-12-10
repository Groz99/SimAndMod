function SourceVector = GlobalSourceGQ_p2(SourceVector,Mesh)
NNodes = Mesh.ngn;
NElements = Mesh.ne;
eID = 1;
for idx = 1 : 2 : NNodes - 2
    SourceVector(idx:idx+2) = SourceVector(idx:idx+2) - LocalSourceGQ(eID,Mesh);
    eID = eID + 1;  
 end