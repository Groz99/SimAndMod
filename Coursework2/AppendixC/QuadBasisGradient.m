%Function to calculate the Gradient of the basis functions in the xi domain
%Using quadratic basis functions defined as in lecture 10
%Manual differentation gives their derivatives.

%Takes:
%localnode - local node position (int)
%Xi - Xi value within the element (float)

%Outputs:
%Grad - Gradient of that basis function (float)

function Grad = QuadBasisGradient(localnode,Xi)

%Note Xpos is the value along the Xi axis

if localnode == 0
    Grad = Xi - 0.5;
elseif localnode == 1
    Grad = -2*Xi  ;   
elseif localnode == 2
    Grad = Xi + 0.5;
else
    error('Local nodes incorrectly indexed')
end