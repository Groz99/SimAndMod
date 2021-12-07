function LocalElementmatrix = ReactionMatrixGQ_p2(eID,msh)
%Easiest way to generation ReactionMatrix is by scaling the mass matrix 
%by lamda as already have a function for this.
%msh = msh = OneDimLinearMeshGen(0,1,9);  
Lamda = (msh.G(eID)*msh.rhob(eID)*msh.cb(eID))/(msh.rho(eID)*msh.rho(eID));
LocalElementmatrix = LocalMassMatrixGQ(eID,msh) * Lamda;
end
