% Test bed for NormSumSquare function. Call using runtests('FUNCTION')
%% Test 1 - N less than 4
% Ans = 4.66667

x = [1 2 3];
SoS = NormSumSquare(x)
assert(abs(SoS - 5) < 1)

%% Test 2 - N more than 4 

% Ans = 11

x = [ 1 2 3 4 5];
SoS = NormSumSquare(x)
assert(abs(SoS - 11) < 1)


%% Test 3 - N negative

x = [ 1 -2 3 -4 -5];
SoS = NormSumSquare(x)
assert(abs(SoS - 11) < 1)

