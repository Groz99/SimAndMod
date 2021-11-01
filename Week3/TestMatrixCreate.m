function Matrix = TestMatrixCreate(a,b,c)

Matrix = zeros(2,2);

Matrix(1,1) = c^3 + 2*b*c + a;
Matrix(1,2) = b^2 + a;
Matrix(2,1) = b^2 + a;
Matrix(2,2) = 2*c^3 + 4*b*c + 5*a;

Matrix