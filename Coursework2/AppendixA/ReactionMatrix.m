%Function to calculate the reaction local element matrix for a given
%mesh element
%Takes:
%Lamda - Reaction coefficient (float)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%Or OneDimSimpleRefinedMeshGen.m (struct)

%Outputs
%LocalElementmatrix - 2x2 LEM of the reaction term (float)
function LocalElementmatrix = ReactionMatrix(Lamda,eID,msh)

%Extract J from msh structure
J = msh.elem(eID).J;

%Form local element matrix using equation derived in the notes
LocalElementmatrix = [ (2*Lamda*J)/3 (Lamda*J)/3  ;
                       (Lamda*J)/3  (2*Lamda*J)/3 ];
             

             
             