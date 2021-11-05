function [GMatrix] = PopulateGlobalMatrix(LocalElementMat,GMatrix)

for idx = 1:(length(GMatrix) - 1)
    
    GMatrix(idx:idx+1,idx:idx+1) = LocalElementMat + GMatrix(idx:idx+1,idx:idx+1)
    
end



