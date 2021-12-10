%Script to plot gamma at locations along the mesh
NElements = 52;
NTsteps = 100;
xloc = linspace(0.001,0.01,100);
ax.XAxis.Exponent = 0
for idx = 1 : length(xloc)
[Cplot, Domain, TDomain,GammaTotal] = SolveLaplaceTransient_GQ_p2_1(NElements,NTsteps,'DL',393.75,'DL',310.15,'CN',xloc(idx));
Gammaplot(idx) = GammaTotal;
end
figure

plot(xloc,Gammaplot);
xlabel('x')
ylabel('Gamma')
