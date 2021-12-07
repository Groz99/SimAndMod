function SourceVector = GlobalSourceGQ(SourceVector,Mesh)
NNodes = Mesh.ngn;
NElements = Mesh.ne;

for idx = 1 : length(SourceVector)
    %eID = (idx+1)/2;
    if idx == 1
        SourceVector(idx) = SourceVector(idx) * Mesh.elem(1).J;
    elseif idx == length(SourceVector)
            SourceVector(idx) = SourceVector(idx) * Mesh.elem(1).J;   
    else
        SourceVector(idx) = SourceVector(idx) * (Mesh.elem(1).J + Mesh.elem(1).J);
    end
    
 end