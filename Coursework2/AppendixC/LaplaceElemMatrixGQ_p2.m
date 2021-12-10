% Calculates the local diffusion element matrix for element eID in the 
% mesh using a GQ and quadratic basis function realisation.

%Takes:
%D - Diffusion coefficient (float)
%eID - Element ID (int)
%msh - Mesh data structure (struct)

%Outputs:
%LocalElementmatrix - 3x3 LEM of the diffusion term (float)
function LocalElementmatrix = LaplaceElemMatrixGQ_p2(eID,msh)

% Initiate variables and Gauss scheme
N=2;
Gauss = CreateGaussScheme(N);
LocalElementmatrix = zeros(3);
J = msh.elem(eID).J; 

%Calculate D based on the location within the Mesh
D = msh.k(eID)/(msh.rho(eID)*msh.c(eID));

%Compute a Guassian quadrature construction for the diffusion LEM using
%Gradient DPsi/DXi of quadratic basis functions
for n = 0:2     
    for m = 0:2
        for i = 1:N
            LocalElementmatrix(n+1,m+1) = LocalElementmatrix(n+1,m+1) + Gauss.wt(i)...
                *(QuadBasisGradient(n,Gauss.xi(i)) * QuadBasisGradient(m,Gauss.xi(i))*(1/J));
        end
    end
end

%Scale with Diffusion coefficient and Jacobian
LocalElementmatrix = LocalElementmatrix*D;
end