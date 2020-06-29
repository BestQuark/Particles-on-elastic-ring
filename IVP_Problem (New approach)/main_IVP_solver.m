function output = main_IVP_solver

% Initial conditions for x and p  
%EXAMPLE: ONE PARTICLE
%x0 = [0 0 0];
%p0 = [1 1 1];
%n = 1;
%L = 1;

%EXAMPLE: TWO PARTICLES
%x0 = [0 0 0; 1 2 3];
%p0 = [4 4 3; 1 2 3];
%n = 2;
%L = [0.5 0.5];


%EXAMPLE: 3 PARTICLES

x0 = [0 0 0; 0.5 0.1 0; 0 -0.3 -0.3];
p0 = [4 4 3; 1 2 3; 5 4 1];
n = 3;
L = [0.3 0.2 0.5];


% Arclength
s = 1;

% Define parameters
params = parameters;

% Solve IVP
output = solve_IVP(x0,p0,n,L,s,params);

% Plot solution

plot_function(output,n);
end