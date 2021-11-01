function SoS = NormSumSquare(x)
%clear all
% x = [ 1 2 3 ];
for N = 1 : length(x) 
    
        y(N) = x(N)^2;
end

 if length(x) <= 5
        SoS = 1/length(x) * sum(y);
    else if N <= 9  
        SoS = 1/(length(x))^0.5 * (sum(y))^0.5;
        else   
            SoS = 1/(length(x))^(1/3) * (sum(y))^(1/3);
    end
 end
 SoS
 