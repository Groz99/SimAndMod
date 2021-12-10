%Function to assemble a Global source vector from local source elements
%As demonstrated in the lecture notes

%Takes:
%SourceVector - Initialised to zeros(N x N float)
%Mesh - Mesh data structure, , generated using OneDimLinearMeshGen.m or 
%OneDimSimpleRefinedMeshGen.m (struct)

%Outputs:
%SourceVector - (N x N float)
function SourceVector = GlobalSource(SourceVector,Mesh)

for idx = 1 : length(SourceVector)
    if idx == 1
        SourceVector(idx) = SourceVector(idx) * Mesh.elem(idx).J;
    elseif idx == length(SourceVector)
            SourceVector(idx) = SourceVector(idx) * Mesh.elem(idx-1).J;   
    else
        SourceVector(idx) = SourceVector(idx) * (Mesh.elem(idx-1).J + Mesh.elem(idx).J);
    end
    
 end