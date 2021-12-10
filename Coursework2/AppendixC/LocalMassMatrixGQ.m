% Calculates the local mass element matrix for element eID in the 
% mesh using a GQ and quadratic basis function realisation.   

%Takes:
%eID - Element ID (int)
%msh - Mesh data structure (struct)

%Outputs:
%LocalElementmatrix - 3x3 LEM of the mass term (float)

function LocalElementmatrix = LocalMassMatrixGQ(eID,msh)

% Initialise Gauss scheme
N=3;
Gauss = CreateGaussScheme(N);
LocalElementmatrix = zeros(3); %Initialise the LEM
J = msh.elem(eID).J;

%Compute a Guassian quadrature construction for the diffusion LEM using
%Gradient DPsi/DXi of quadratic basis functions

for n = 0:2     
    for m = 0:2
        for i = 1:N
            LocalElementmatrix(n+1,m+1) = LocalElementmatrix(n+1,m+1) + Gauss.wt(i)...
                *(EvalQuadBasis(n,Gauss.xi(i)) * EvalQuadBasis(m,Gauss.xi(i)));
        end
    end
end
%Scale with by the jacobian
LocalElementmatrix = LocalElementmatrix*J;
end