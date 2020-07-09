function output = main_continuation_solver

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

%x0 = [0 0 0; 0.5 0.1 0; 0 -0.3 -0.3];
%p0 = [4 4 3; 1 2 3; 5 4 1];
%n = 3;
%L = [0.3 0.2 0.5];

x0 = rand(7,3);
p0 = 3*rand(7,3);
n=7;
L = 2*rand(1,7);

% Arclength
s = 1;

% Define parameters
params = parameters;

% List of Desired boundary condition for x(tf)
Reqs =  linspace(0,10,50);

% Solve the continuation problem
output = solve_continuation(x0,p0,n,L,s,Reqs, params);

end