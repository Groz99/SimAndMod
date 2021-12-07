function [ val ] = EvalField(msh,field,eID,xipt)
%EvalField Evaluates a nodally stored scalar field at a given xi
%NB - This script was developed and verified using code provided by 
%Dr Cookson during and following Tutorial 5

%EvalField Evaluates a nodally stored scalar field at a given xi
%point in an element

% Evaluates a scalar data field (stored in field) that is
%represented on a linear Lagrange finite element mesh (msh), 
%when given a xi coordinate and an element id
 
 psi = [EvalBasis(0,xipt) EvalBasis(1,xipt)]; 
%Get vector containing basis function values at xipt
 vcoeff = [field(msh.elem(eID).n(1)); field(msh.elem(eID).n(2))];
%Get nodal values for element eID
 val = psi*vcoeff; 
 %Dot product the two together to sum up the coefficients*basis functions
 %to give the final interpolated value
 
end