
Gaussorder = 3;
Gauss = CreateGaussScheme(Gaussorder);
Xpos = 0.4;

NElements = 10;
TposArray = [0.1  0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
Nruns = length(TposArray);
Evec = zeros(Nruns,1);
h = zeros(Nruns,1);
NTsteps = 1000;

for methodidx = ["CN" "FE" "BE"]
tic
    for idxx = 1 : length(TposArray)
        
        [C,Domain,TDomain] = SolveLaplaceTransient_GQ(2,0,NElements,NTsteps,'DL',0,'DL',1,methodidx); %Using nonGQ,linear                                                                                               
        Msh = OneDimLinearMeshGen(0,1,NElements-1);                                           %Basis functions
        
        %{
        figure
        plot(TDomain,C(5,:))
        xlabel('Time')
        ylabel('C')
        figure
        plot(Domain,C(:,1))
        xlabel('X')
        ylabel('C')
        %}
        
        for eID = 1 : NElements - 1 % For all elements

            xlims = Msh.elem(eID).x;
            x0 = xlims(1);
            x1 = xlims(2);
            c0 = C(eID,NTsteps*TposArray(idxx));
            c1 = C(eID+1,NTsteps*TposArray(idxx));

            for idx = 1 : Gaussorder % For all gauss points in each element
                J = Msh.elem(eID).J;

                CXi = c0*((1-Gauss.xi(idx))/2) + c1*((1+Gauss.xi(idx))/2);
                xXi = x0*((1-Gauss.xi(idx))/2) + x1*((1+Gauss.xi(idx))/2);

                Evec(idxx) = Evec(idxx) + (Gauss.wt(idx)*J*(TransientAnalyticSoln(xXi,TposArray(idxx)) - CXi))^2;

            end      

        end

        h(idxx) = (x1-x0);
    end
    %need to square root if not abs
    Evec = ((Evec).^0.5);
    
    ErrorTimeVec.(methodidx) = [Evec,TposArray']
toc    
end

figure
hold on
plot(ErrorTimeVec.CN(:,2),ErrorTimeVec.CN(:,1),'LineWidth',1)
%figure
plot(ErrorTimeVec.BE(:,2),ErrorTimeVec.BE(:,1),'LineWidth',1)
%figure
plot(ErrorTimeVec.FE(:,2),ErrorTimeVec.FE(:,1),'LineWidth',1)
xlabel('Time')
ylabel('L2 Norm error')
legend('Crank Nicholson','Backwards Euler','Forwards Euler')


