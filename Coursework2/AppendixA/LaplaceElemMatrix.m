%Function to calculate the diffusion local element matrix for a given
%mesh element
%Takes:
%D - Diffusion coefficient (float)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%OneDimSimpleRefinedMeshGen.m (struct)

function LocalElementmatrix = LaplaceElemMatrix(D,eID,msh)

%Extract J from msh structure
J = msh.elem(eID).J;

%Form local element matrix using equation derived in the notes
LocalElementmatrix = [ D/(2*J) -D/(2*J) ;
                       -D/(2*J) D/(2*J)];
             
             