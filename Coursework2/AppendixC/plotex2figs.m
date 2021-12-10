NElements = 52;
NTsteps = 5000;
ax.XAxis.Exponent = 0
[Cplot, Domain, TDomain,GammaTotal] = SolveLaplaceTransient_GQ_p2_1(NElements,NTsteps,'DL',393.75,'DL',310.15,'CN',0.00166667);
Tmax = 50;
Ttoplot = [0.01 0.05 0.1 1 5 10 50];
figure
hold on
for idx = 1 : length(Ttoplot)
plot(Domain,Cplot(:,ceil(Ttoplot(idx)/Tmax * NTsteps)), 'LineWidth', 1.5)
end
xlabel('x')
ylabel('T')
legend('0.01','0.05','0.1','1','5','10', '50')