%Creates Gauss-Legendre integration weights & points for npoints
%Can create a Gauss scheme for up to 3 gauss points.
%NB - This script was developed and verified using code provided by Dr
%Cookson during and following Tutorial 5

function [gauss] = CreateGaussScheme(npoints)

if(npoints < 1) || (npoints > 3)
 error('Gauss:argChk','Scheme not implemented.')
end
gauss.np = npoints;
gauss.wt = zeros(npoints,1);
gauss.xi = zeros(npoints,1);
if(npoints==1)
 gauss.wt(1) = 2.0;
 gauss.xi(1) = 0.0;

elseif(npoints==2)

 gauss.wt(:) = 1.0;
 gauss.xi(1) = -sqrt(1/3);
 gauss.xi(2) = sqrt(1/3);

elseif(npoints==3)
 gauss.wt(1) = 8/9;
 gauss.wt(2) = 5/9;
 gauss.wt(3) = 5/9;
 gauss.xi(1) = 0.0;
 gauss.xi(2) = -sqrt(3/5);
 gauss.xi(3) = sqrt(3/5);

end

end