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