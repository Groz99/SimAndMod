% Function to compute a finite difference stepping scheme for numerical
% methods  - OUTPUTS Dc/Dt, the time derivative of the solution and that
% time and place in space 

% time and space are implicit in F

% Note this is currently in 1-D, no i subscript for F

% CN - Theta = 1/2
% FE - Theta = 0
% BE - Theta = 1

function solnderivative = FiniteDifference(F, method)

if method = 'CN'
    stepdelta  = 1/2(F(