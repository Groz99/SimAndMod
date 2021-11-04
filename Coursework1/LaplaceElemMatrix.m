function LocalElementmatrix = LaplaceElemMatrix(D,eID,msh)


%formula in terms of J? 

% J = x1-x0/2
Elsize = msh.elem(eID).x(2) - msh.elem(eID).x(1); 

%Dont think this is needed
J = msh.elem(eID).J;

%LocalElementmatrix = [ D/Elsize -D/Elsize ;
%                       -D/Elsize D/Elsize];

%Think this is better
LocalElementmatrix = [ D/(2*J) -D/(2*J) ;
                       -D/(2*J) D/(2*J)];
             
%Passes 5 out of 5
             
             