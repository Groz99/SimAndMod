%Script to enhance the mesh data structure to include material parameters
%This will allow discontinuities to be handled such as in part 2 of the
%problem
%Maps k,G,rho,c,rhob,cb,Tb to the appropriate elements in the mesh

%Takes:
%msh - Mesh generated using OneDimLinearMeshGen (struct)
%xmin - Lower limit of x domain (float)
%xmax - Upper limit of x domain (float)

function msh = EnhanceMeshData(msh,xmin,xmax)

%Shift x domain into positive space 
xmax = xmax - xmin;
xmin = 0;

%Define location of layers of skin
Epos = 0.00166667;
Dpos = 0.005;
Bpos = 0.01;

%scale values up between 0 and 1 to operate over simple domain

Epos = Epos * xmax/Bpos;
Dpos = Dpos * xmax/Bpos;
Bpos = Bpos * xmax/Bpos;

%Define parameter values from table

k = [25 40 20];
G = [0 0.0375 0.0375];
rho = [1200 1200 1200];
c = [3300 3300 3300];
rhob = [0 1060 1060];
cb = [0 3770 3770];
Tb = [0 310.15 310.15];

%Load values into the mesh data structure by their element id

%Node positions
Enode = ceil(msh.ne*Epos) ;
Dnode = ceil(msh.ne*Dpos);
Bnode = ceil(msh.ne*Bpos);

%Load values as per each layer of skin
for idx = 1 : Enode
    msh.k(idx) = k(1);
    msh.G(idx) = G(1);
    msh.rho(idx) = rho(1);
    msh.c(idx) = c(1);
    msh.rhob(idx) = rhob(1);
    msh.cb(idx) = cb(1);
    msh.Tb(idx) = Tb(1);
end

for idx = Enode : Dnode
    msh.k(idx) = k(2);
    msh.G(idx) = G(2);
    msh.rho(idx) = rho(2);
    msh.c(idx) = c(2);
    msh.rhob(idx) = rhob(2);
    msh.cb(idx) = cb(2);
    msh.Tb(idx) = Tb(2);
end

for idx = Dnode : Bnode
    msh.k(idx) = k(3);
    msh.G(idx) = G(3);
    msh.rho(idx) = rho(3);
    msh.c(idx) = c(3);
    msh.rhob(idx) = rhob(3);
    msh.cb(idx) = cb(3);
    msh.Tb(idx) = Tb(3);
end
   

