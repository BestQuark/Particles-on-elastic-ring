function params = parameters

% This function contains parameters that are used when solving the
% differential equations

% parameters for solving ODEs
params.ode_options = odeset('AbsTol',1e-8,'RelTol',1e-8);

% tolerance for determining when to start checking det(X(t))
params.detXtol = 1e-10;

% maximium number of iterations to run BVP loop
params.nmax = 200; 

% error tolerance for solution of BVP
params.tol = 1e-3; 

% maximum step size to make in p0 when solving BVP
params.maxstep = 1; 

end