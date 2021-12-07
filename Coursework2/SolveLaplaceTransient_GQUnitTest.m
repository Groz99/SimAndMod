%% Test 1: Compare the GQ version of the laplace solver to the directly solved version
clear all
tol = 1e-14
[C, Domain, TDomain] = SolveLaplaceTransient(2,0,5,100,'DL',0,'DL',1,'CN');
[CGQ, DomainGQ, TDomainGQ] = SolveLaplaceTransient_GQ(2,0,5,100,'DL',0,'DL',1,'CN');
assert(sum(sum(C - CGQ)) <= tol)