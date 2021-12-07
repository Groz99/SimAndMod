function Psi  = EvalQuadBasis(localnode,Xi)
%EvalBasis Evaluates linear Lagrange basis functions
%NB - This script was developed and verified using code provided by Dr
%Cookson during and following Tutorial 5

%Modified to use Quadratic basis functions

% Given the local node id (lnid) for a linear Lagrange element, and
% a xi coordinate (between [-1,1]), returns the correpsonding value of
% the basis function for that local node, at that xi point

%If structure is simplest realisation here

if localnode == 0
    Psi = (Xi*(Xi-1))/2;
elseif localnode == 1
    Psi = 1 - Xi^2;
elseif localnode == 2
    Psi = (Xi*(Xi+1))/2;
end