function LocalElementmatrix = ReactionMatrix(Lamda,eID,msh)

%Elsize = msh.elem(eID).x(2) - msh.elem(eID).x(1); 

%formula in terms of J? 

J = msh.elem(eID).J;

LocalElementmatrix = [ (2*Lamda*J)/3 (Lamda*J)/3  ;
                       (Lamda*J)/3  (2*Lamda*J)/3 ];
             

             
             