function [Gradient] = QuadBasisGradient(localnode,Xi)
%Using quadratic basis functions defined as in lecture 10
%Manual differentation gives their derivatives:
%Note Xpos is the value along the Xi axis

if localnode == 0
    Gradient = Xi - 0.5;
elseif localnode == 1
    Gradient = -2*Xi  ;
    
elseif localnode == 2
    Gradient = Xi + 0.5;
else
    error('Local nodes incorrectly indexed')
end