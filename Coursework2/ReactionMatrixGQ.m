function LocalElementmatrix = ReactionMatrixGQ(Lamda,eID,msh)
%Easiest way to generation ReactionMatrix is by scaling the mass matrix 
%by lamda as already have a function for this.
%msh = msh = OneDimLinearMeshGen(0,1,9);  
LocalElementmatrix = LocalMassMatrixGQ(eID,msh) * Lamda;
end
