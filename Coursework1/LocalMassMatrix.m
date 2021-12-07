%Function to calculate the reaction local element Mass matrix for a given
%mesh element
%Takes:
%Lamda - Reaction coefficient (int)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%Or OneDimSimpleRefinedMeshGen.m

function LocalElementmatrix = LocalMassMatrix(eID,msh)

%Extract J from msh structure
J = msh.elem(eID).J;

%Form local element matrix using equation derived in the notes
LocalElementmatrix = [ (2*J)/3 J/3  ;
                      J/3 (2*J)/3  ];
             