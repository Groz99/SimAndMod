% Function to calculate the level of tissue damage at a given location in
% the mesh

function InterpC = QuadInterpolate(C,msh,xloc)

NNodes = msh.ngn;

% Need to use basis functions to accurately interpolate between nodes
xmax = msh.nvec(end);
xpos = xloc/xmax; %The exact position on the mesh

%Find which nodes this is between
xlower = floor(NNodes*xpos);
xupper = ceil(NNodes*xpos);

if xlower == xupper
   InterpC = C(xlower);
   return
end

%Find x value at these nodes
x0 = msh.nvec(xlower);
x1 = msh.nvec(xupper);

%Find xi in this element

xi = 2*(xloc-x0)/(x1-x0) -1;

%Recall Cs at this position
c0 = C(xlower);
c2 = C(xupper);
c1 = (c0 + c2)/2;

%Use quadratic basis functions to interpolate
InterpC = c0 *(xi*(xi-1))/2 + c1 * (1-xi^2) + c2 * (xi*(xi+1))/2;


