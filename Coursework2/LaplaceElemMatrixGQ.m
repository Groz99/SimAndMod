    function LocalElementmatrix = LaplaceElemMatrixGQ(D,eID,msh)
    % Calculates the local diffusion element matrix for element eID in the 
    % mesh using a GQ and quadratic basis function realisation.
    % msh = OneDimLinearMeshGen(0,1,9)
    % Call LaplaceElemMatrixGQ(2,1,msh)
    %D = 2;
    %eID = 1;
    %NNodes = 10;
    %NElements = NNodes -1;
    %msh = OneDimLinearMeshGen(0,1,NElements);  
    %----------------------------------------------------------------------    
    % Initiate variables
    N=2;
    Gauss = CreateGaussScheme(N);
    LocalElementmatrix = zeros(3); %Initialise the LEM
    J = msh.elem(eID).J; % Note jacobian is same for whole matrix
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