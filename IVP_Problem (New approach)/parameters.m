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
params.maxstep = 1; 

end