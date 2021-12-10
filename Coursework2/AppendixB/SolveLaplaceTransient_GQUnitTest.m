%% Test 1: Compare the GQ version of the laplace solver to the directly solved version
clear all
tol = 0.01; %(0.01% tolerance in nodal values at each timestep)
addpath G:\SimAndMod\Coursework2\AppendixA

NTsteps = 1000;

%Run the two models
[C, Domain, TDomain] = SolveLaplaceTransient(1,1,101,NTsteps,'DL',0,'DL',1,'CN');
[CGQ, DomainGQ, TDomainGQ] = SolveLaplaceTransient_GQ(1,1,50,NTsteps,'DL',0,'DL',1,'CN');

%Sum nodal values
sumC = sum(sum(C));
sumCGQ = sum(sum(CGQ));

%Average difference in solutions per timestep
TotalDelta = (sumC-sumCGQ) ;
DeltaPerT = (TotalDelta/NTsteps);
PercentageChange = DeltaPerT/sumC * 100

assert(abs(PercentageChange) < tol)