% Script to populate data structure with car parameters
bhps = [100 200 300 440];
colours = ["black" "blue" "grey" "red"];
weights = [ 2.1 2.5 2.9 3.1 ];
fuels = [ "diesel" "petrol" "diesel" "petrol"];
models = [ "ford" "bmw" "audi" "mustang"];

car = struct('bhp', bhps, 'colour', colours, 'weight', weights, 'fuel', fuels, 'model', models)
%car = struct('bhp', [100 200 300 440], 'colour', [black blue grey red],  

% Dont understand what this part wants, what should car(1) hold? 
%{
for N = 1 : length(bhps) 
    car(N) = car.
    
end
%}