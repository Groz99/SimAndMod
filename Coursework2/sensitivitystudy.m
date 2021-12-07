clear all

Gaussorder = 3;
Gauss = CreateGaussScheme(Gaussorder);



TposArray = [0.1  0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];

Nruns = length(TposArray);


NElements = 520;
NTsteps = 10;

Runcount = 1;
DeltaE(Runcount) = 1;
TotalE0 = 100;

while DeltaE(end) > 0.01
    for idxx = 1 : length(TposArray)
        Evec = zeros(Nruns,1);
        [C,Domain,TDomain] = SolveLaplaceTransient_GQ(2,0,NElements,NTsteps,'DL',0,'DL',1,'CN');                                                                                               
        Msh = OneDimLinearMeshGen(0,1,NElements-1);                                          
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
    end
    %need to square root if not abs
    Evec = ((Evec).^0.5);

    TotalE1 = sum(Evec);
    DeltaE(Runcount) = abs((TotalE0 - TotalE1)/TotalE0)
    TotalE0 = TotalE1;
    
    NTsteps = NTsteps + 10;
    Runcount = Runcount + 1;
end
