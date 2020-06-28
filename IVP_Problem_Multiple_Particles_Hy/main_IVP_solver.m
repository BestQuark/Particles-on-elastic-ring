function output = main_IVP_solver

% Initial conditions for x and p  

%EXAMPLE: n PARTICLES
%Initialize particles and choose number of particles we want to solve
x0 = [0 0 0; 0.3 0.4 0.5; 0.2 0.7 0.1];
p0 = [4 4 3; 1 2 3; 3 4 1];
n = 3;
L = [0.4 0.4 0.2];
% Define parameters
params = parameters;

% Solve IVP
for i=1:n  
    output{i} = solve_IVP(x0(i,:),p0(i,:),L(i),params);
end
% Plot solution
plot_function_new(output,n)

end