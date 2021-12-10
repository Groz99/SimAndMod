%Script to calculate the neccesary temperature reduction to avoid a burn
%Set stepping increment for search algorithm

TempStep = 0.1;
% at x = E
GammaTotal = 1;
TempReduce = 50;
xloc = 0.00166667;
while GammaTotal >= 1
    [Cplot, Domain, TDomain, GammaTotal] = SolveLaplaceTransient_GQ_p2_1(52,100,'DL',393.75-TempReduce,'DL',310.15,'CN',xloc);
    TempReduce = TempReduce + TempStep;
end
Epidermisburn = TempReduce

% at x = D
GammaTotal = 1;
TempReduce = 40;
xloc = 0.005;
while GammaTotal >= 1
    [Cplot, Domain, TDomain,GammaTotal] = SolveLaplaceTransient_GQ_p2_1(52,100,'DL',393.75-TempReduce,'DL',310.15,'CN',xloc);
    TempReduce = TempReduce + TempStep;
end

Dermisburn = TempReduce