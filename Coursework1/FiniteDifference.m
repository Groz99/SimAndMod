% Function to compute a finite difference stepping scheme for numerical
% methods  - OUTPUTS Dc/Dt, the time derivative of the solution and that
% time and place in space 

% time and space are implicit in F

% Note this is currently in 1-D, no i subscript for F

function solnderivative = FiniteDifference(F, method)

if method = 'CN'
    stepdelta  = 1/2(F(