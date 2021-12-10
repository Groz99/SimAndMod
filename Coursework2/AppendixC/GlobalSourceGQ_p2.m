%Function to assemble a Global source vector from local source elements
%As demonstrated in the lecture notes

%Takes:
%SourceVector - Initialised to zeros(N x N float)
%Mesh - Mesh data structure, , generated using OneDimLinearMeshGen.m or 
%OneDimSimpleRefinedMeshGen.m (struct)

%Outputs:
%MassMatrix - (N x N float)

function SourceVector = GlobalSourceGQ_p2(SourceVector,Mesh)
NNodes = Mesh.ngn;
NElements = Mesh.ne;
eID = 1;
for idx = 1 : 2 : NNodes - 2
    SourceVector(idx:idx+2) = SourceVector(idx:idx+2) - LocalSourceGQ(eID,Mesh);
    eID = eID + 1;  
 end