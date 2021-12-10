%Function to calculate the local source vector for each element based on
%material properties in the skin

%Takes:
%eID - Element ID (int)
%msh - Enhanced mesh data structure (struct)

%Outputs:
%LocalElementmatrix - 3x1 local source vector (float)

function localsource = LocalSourceGQ(eID,msh)

%Initialise a 3x1 vector
localsource = zeros(3,1);

%Determine source terms based on location within Mesh and populate 1D vector
F = (msh.rhob(eID) * msh.cb(eID) * msh.G(eID))/(msh.rho(eID)*msh.c(eID)) * msh.Tb(eID);
J = msh.elem(eID).J;
localsource(:) = F*J;