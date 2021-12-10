%Script to calculate the L2 Norm of the LaplaceSolver and assess its
%convergence for verification purposes

Gaussorder = 3;
Gauss = CreateGaussScheme(Gaussorder);

%Select arbitrary x position
Xpos = 0.4;
% Select time step, 0.5 = halfway through run
Tpos = 0.5; 

%Set run parameters and initialise output values
NTsteps = 1000;
NNodesvec =  [4 8 16 32 64 128];
Nruns = length(NNodesvec);
Evec = zeros(Nruns,1);
h = zeros(Nruns,1);

for idxx = 1 : Nruns % For many different run lengths
    [C,Domain,TDomain] = SolveLaplaceTransient(2,0,NNodesvec(idxx),NTsteps,'DL',0,'DL',1,'CN'); %Using nonGQ,linear                                                                                               
    Msh = OneDimLinearMeshGen(0,1,NNodesvec(idxx)-1);                                              %Basis functions
    for eID = 1 : NNodesvec(idxx) - 1 % For all elements

        xlims = Msh.elem(eID).x;
        x0 = xlims(1);
        x1 = xlims(2);
        c0 = C(eID,NTsteps*Tpos);
        c1 = C(eID+1,NTsteps*Tpos);
        
        for idx = 1 : Gaussorder % For all gauss points in each element
            J = Msh.elem(eID).J;
            
            %Find C, xi points
            CXi = c0*((1-Gauss.xi(idx))/2) + c1*((1+Gauss.xi(idx))/2);
            xXi = x0*((1-Gauss.xi(idx))/2) + x1*((1+Gauss.xi(idx))/2);
            
            %Calculate L2 norm by GQ
            Evec(idxx) = Evec(idxx) + (Gauss.wt(idx)*J*(TransientAnalyticSoln(xXi,Tpos) - CXi))^2;

        end      
   
    end
    
    %Calculate element size
    h(idxx) = (x1-x0);
end

%RMS value
Evec = ((Evec).^0.5);

%Plot L2 norm convergence
loglog(NNodesvec-1,Evec)
xlabel('Number of mesh elements')
ylabel('L2 Norm')

%Calculate gradient and output to terminal
grad = (log(h(1)) - log(h(end)))/(log(Evec(1)) - log(Evec(end)));
disp(['Gradient of line: ', num2str(grad)])

