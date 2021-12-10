function localsource = LocalSourceGQ(eID,msh)

NElements = msh.ne;
NNodes = msh.ngn;
localsource = zeros(3,1);
F = (msh.rhob(eID) * msh.cb(eID) * msh.G(eID))/(msh.rho(eID)*msh.c(eID)) * msh.Tb(eID);
J = msh.elem(eID).J;
localsource(:) = F*J;