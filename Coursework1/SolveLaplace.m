% Set boundary conditions

%VN - Gradient

% At x = 0
dcdx = 2;

%Dirichlet - Fixed
% At x = 1
c = 0;
%c = 1;

%Material parameteres
D = 2;
%Lamda = 6;
Lamda = 0; % For this excercise there is no Lamda
%Create global mesh
xmin = 0;
xmax = 1;
NNodes = 10;


GMesh = OneDimLinearMeshGen(xmin,xmax,NNodes); % Local element number nodes same as global?? ;

GMatrix = zeros(NNodes,NNodes);
GSource = zeros(NNodes); % Source term is all 0s for poissons

%Form local element matrices as struct

for idx = 1: length(GMatrix) -1
    
    % Generate diffusion local elements and populate global matrix
    LocalMatrix = LaplaceElemMatrix(D,idx,GMesh);    
    GMatrix(idx:idx+1,idx:idx+1) = LocalMatrix + GMatrix(idx:idx+1,idx:idx+1);
    
    % Generate reaction local elements and populate global matrix
    LocalMatrix = ReactionMatrix(Lamda,idx,GMesh);
    GMatrix(idx:idx+1,idx:idx+1) = LocalMatrix + GMatrix(idx:idx+1,idx:idx+1)
    
    
end

%for
    %source terms
%end


%Enforce BCs
% Specifically for c = 0 at at x = 1
GMatrix(end,:) = 0
GMatrix(end) = 1

    
    
