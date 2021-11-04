function LocalElementmatrix = ReactionMatrix(lamda,eID,msh)

%Elsize = msh.elem(eID).x(2) - msh.elem(eID).x(1); 

%formula in terms of J? 

J = msh.elem(eID).J;

LocalElementmatrix = [ (2*lamda*J)/3 (lamda*J)/3  ;
                       (lamda*J)/3  (2*lamda*J)/3 ];
             

             
             