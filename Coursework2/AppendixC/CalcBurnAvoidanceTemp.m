%Script to calculate the neccesary temperature reduction to avoid a burn
%Set stepping increment for search algorithm

%Define a temperature delta to step through. 
%This is the precision this script is searching to
TempStep = 0.1;

% at the Epidermis, Gamma = 1 for second degree burn
GammaTotal = 1;
TempReduce = 50;
xloc = 0.00166667;

%Run until gamma is reduced below 1
while GammaTotal >= 1
    [Cplot, Domain, TDomain, GammaTotal] = SolveLaplaceTransient_GQ_p2_1(52,100,'DL',393.75-TempReduce,'DL',310.15,'CN',xloc);
    TempReduce = TempReduce + TempStep;
end
Epidermisburn = TempReduce

% at the Dermis, Gamma = 1 for third degree burn
GammaTotal = 1;
TempReduce = 40;
xloc = 0.005;

%Run until gamma is reduced below 1
while GammaTotal >= 1
    [Cplot, Domain, TDomain,GammaTotal] = SolveLaplaceTransient_GQ_p2_1(52,100,'DL',393.75-TempReduce,'DL',310.15,'CN',xloc);
    TempReduce = TempReduce + TempStep;
end
Dermisburn = TempReduce