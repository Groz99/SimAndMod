%Function to calulate LocalElementmatrix for reaction term

%Takes:
%Lamda - Reaction coefficient (float)
%eID - Element number (int)
%msh - Mesh data structure, generated using OneDimLinearMeshGen.m or 
%Or OneDimSimpleRefinedMeshGen.m (struct)

%Outputs
%LocalElementmatrix - 2x2 LEM of the reaction term (float)

function LocalElementmatrix = ReactionMatrixGQ(Lamda,eID,msh)
%Easiest way to generation ReactionMatrix is by scaling the mass matrix 
%by lamda as already have a function for this.

LocalElementmatrix = LocalMassMatrixGQ(eID,msh) * Lamda;
end
