%Script to compare the error in each differencing method at different
%timepoints

%Generate a Gauss scheme
Gaussorder = 3;
Gauss = CreateGaussScheme(Gaussorder);

%Define arbitrary X position in mesh
Xpos = 0.4;

%Define parameters and sample points
NElements = 10;
NTsteps = 1000;
TposArray = [0.1  0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];

%Instantiate vectors
Nruns = length(TposArray);
Evec = zeros(Nruns,1);
h = zeros(Nruns,1);


%L2 Norm functional only for linear basis functions
addpath G:\SimAndMod\Coursework2\AppendixA

%For all possible differencing methods
for methodidx = ["CN" "FE" "BE"]
tic
    for idxx = 1 : length(TposArray)
        
        [C,Domain,TDomain] = SolveLaplaceTransient(2,0,NElements,NTsteps,'DL',0,'DL',1,methodidx); %Using nonGQ,linear                                                                                               
        Msh = OneDimLinearMeshGen(0,1,NElements-1);                                                %Basis functions
       
        for eID = 1 : NElements - 1 % For all elements

            xlims = Msh.elem(eID).x;
            x0 = xlims(1);
            x1 = xlims(2);
            c0 = C(eID,NTsteps*TposArray(idxx));
            c1 = C(eID+1,NTsteps*TposArray(idxx));

            for idx = 1 : Gaussorder % For all gauss points in each element
                J = Msh.elem(eID).J;
                
                %Find solution, xi points
                CXi = c0*((1-Gauss.xi(idx))/2) + c1*((1+Gauss.xi(idx))/2);
                xXi = x0*((1-Gauss.xi(idx))/2) + x1*((1+Gauss.xi(idx))/2);
                
                %Find L2 norm
                Evec(idxx) = Evec(idxx) + (Gauss.wt(idx)*J*(TransientAnalyticSoln(xXi,TposArray(idxx)) - CXi))^2;

            end      

        end

        h(idxx) = (x1-x0);
    end
    
    Evec = ((Evec).^0.5);
    
    ErrorTimeVec.(methodidx) = [Evec,TposArray'];
toc    
end


%Produce plot of L2 norm for each time point
figure
hold on
plot(ErrorTimeVec.CN(:,2),ErrorTimeVec.CN(:,1),'LineWidth',1)
plot(ErrorTimeVec.BE(:,2),ErrorTimeVec.BE(:,1),'LineWidth',1)
plot(ErrorTimeVec.FE(:,2),ErrorTimeVec.FE(:,1),'LineWidth',1)
xlabel('Time')
ylabel('L2 Norm error')
legend('Crank Nicholson','Backwards Euler','Forwards Euler')


