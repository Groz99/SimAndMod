%Script to verify the L2 Norm of the LaplaceSolver and assess convergence
% THIS IS LINEAR VERSION
close all

hold off
Gaussorder = 3;
Gauss = CreateGaussScheme(Gaussorder);
Xpos = 0.4;

Tpos = 0.5; % Select time step, 0.5 = halfway through run
NTsteps = 1000;
%Msh = OneDimLinearMeshGen(0,1,NNodes-1);

%Ce = TransientAnalyticSoln(x,t);
NNodesvec =  [4 8 16 32 64 128];
Nruns = length(NNodesvec);
Evec = zeros(Nruns,1);
h = zeros(Nruns,1);


for idxx = 1 : Nruns % For many different run lengths
    [C,Domain,TDomain] = SolveLaplaceTransient_GQ(2,0,NNodesvec(idxx),NTsteps,'DL',0,'DL',1,'CN'); %Using nonGQ,linear                                                                                               
    Msh = OneDimLinearMeshGen(0,1,NNodesvec(idxx)-1);                                           %Basis functions
    for eID = 1 : NNodesvec(idxx) - 1 % For all elements

        xlims = Msh.elem(eID).x;
        x0 = xlims(1);
        x1 = xlims(2);
        c0 = C(eID,NTsteps*Tpos);
        c1 = C(eID+1,NTsteps*Tpos);
        
        for idx = 1 : Gaussorder % For all gauss points in each element
            J = Msh.elem(eID).J;

            CXi = c0*((1-Gauss.xi(idx))/2) + c1*((1+Gauss.xi(idx))/2);
            xXi = x0*((1-Gauss.xi(idx))/2) + x1*((1+Gauss.xi(idx))/2);

            Evec(idxx) = Evec(idxx) + (Gauss.wt(idx)*J*(TransientAnalyticSoln(xXi,Tpos) - CXi))^2;

        end      
   
    end
    %h(idxx) = 1/NNodesvec(idxx)
    h(idxx) = (x1-x0);
end

%need to square root if not abs
Evec = ((Evec).^0.5);
%   hinv = h.^-1;
%plot(log(h),log(Evec))
%plot(log(Evec),log(h))

loglog(NNodesvec-1,Evec)
xlabel('Number of mesh elements')
ylabel('L2 Norm')

grad = (log(h(1)) - log(h(end)))/(log(Evec(1)) - log(Evec(end)));
disp(['Gradient of line: ', num2str(grad)])
%text(log(Evec(4)),log(h(4)), ['Gradient' num2str(grad)])
%Correct implementation gives 1/gradient - This needs fixing
%grad = ((log(Evec(1)) - log(Evec(end)))/(log(h(1)) - log(h(end))))
