%Function to calculate the local reaction matrices for each element
%This version scales by a lamda that is dynamically calculated along the
%mesh

%Takes:
%eID - Element ID (int)
%msh - Mesh data structure (struct)

%Outputs:
%LocalElementmatrix - 3x3 LEM of the reaction term (float)

function LocalElementmatrix = ReactionMatrixGQ_p2(eID,msh)

%Easiest way to generation ReactionMatrix is by scaling the mass matrix 
%by lamda as already have a function for this.

%Extract mesh material properties to calculate lamda
Lamda = (msh.G(eID)*msh.rhob(eID)*msh.cb(eID))/(msh.rho(eID)*msh.c(eID));
LocalElementmatrix = LocalMassMatrixGQ(eID,msh) * Lamda;
end
