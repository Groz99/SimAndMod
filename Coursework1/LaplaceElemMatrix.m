%Function to calculate the diffusion local element matrix for a given
%mesh element
%Takes:
%D - Diffusion coefficient (int)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%Or OneDimSimpleRefinedMeshGen.m

function LocalElementmatrix = LaplaceElemMatrix(D,eID,msh)

%Extract J from msh structure
J = msh.elem(eID).J;

%Form local element matrix using equation derived in the notes
LocalElementmatrix = [ D/(2*J) -D/(2*J) ;
                       -D/(2*J) D/(2*J)];
             
%Passes 5 out of 5
             
             