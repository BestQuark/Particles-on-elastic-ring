function params = parameters

% This function contains parameters that are used when solving the
% differential equations
% this func mainly records the value of parameters as a struct

% parameters for solving ODEs
% the pre-assumed error term/tolerance
params.ode_options = odeset('AbsTol',1e-8,'RelTol',1e-8);

% tolerance for determining when to start checking det(X(t))
params.detXtol = 1e-10;

% maximium number of iterations to run BVP loop
params.nmax = 200; 

% error tolerance for solution of BVP
params.tol = 1e-3; 

% maximum step size to make in p0 when solving BVP, "normalized step"
params.maxstep = 0.3; 

% if for a Lennard Jones potential,set the value of epsilon to 0.3(e.g.)
%Lennard Jones potential 
%Vij(x1,y1,x2,y2) = epsilon * ((Req/Rij)^(12) - (Req/Rij)^6 );
params.LJ_potential_epsilon = 0.3;

% if for Coulumb potential coefficient k
params.Coulumb_potential_coefficient = 8.99e9;
end