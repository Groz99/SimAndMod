function localsource = LocalSourceGQ(eID,Mesh)

NElements = Mesh.ne;
NNodes = Mesh.ngn;
localsource = zeros(3);
F = (Mesh.rhob(eID) * Mesh.cb(eID) * msh.G(eID))/(msh.rho(eID)*msh.cp(eID)*msh.Tb(eID));
J = Mesh.elem(eID).J;
localsource(:) = FJ;