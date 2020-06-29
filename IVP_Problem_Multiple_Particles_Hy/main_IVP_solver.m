function output = main_IVP_solver

% Initial conditions for x and p  
%Initialize particles and choose number of particles we want to solve

% EXAMPLE 1: n = 1 PARTICLES
% x0 = [0 0 0];
% p0 = [1 1 1];
% n = 1;
% L = 1;

% EXAMPLE 2: n = 2 PARTICLES
% x0 = [0 0 0; 1 2 3];
% p0 = [4 4 3; 1 2 3];
% n = 2;
% L = [0.5 0.5];

%EXAMPLE 3: n = 3 PARTICLES
% x0 = [0 0 0; 0.3 0.4 0.5; 0.2 0.7 0.1];
% p0 = [4 4 3; 1 2 3; 3 4 1];
% n = 3;
% L = [0.4 0.4 0.2];

%EXAMPLE 4: Another n = 3 PARTICLES
x0 = 0.5 *[0 0 0; 1 2 3; 0 -2 -2];
p0 = 0.5*[4 4 3; 1 2 3; 5 4 1];
n = 3;
L = [0.3 0.2 0.5];

% Define parameters
params = parameters;

% Solve IVP
for i=1:n  
    output{i} = solve_IVP(x0(i,:),p0(i,:),L(i),params);
end
% Plot solution
plot_function_new(output,n)

end