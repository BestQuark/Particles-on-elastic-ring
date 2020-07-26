function output = main_BVP_solver

% This function uses a shooting method to solve the boundary value problem
% for the following system:
% x1' = sin(x3)   x2' = cos(x3)   x3' = p3
% p1' = 0   p2' = 0   p3' = p1*sin(x3) - p2*cos(x3)
% Function Outputs:
%   output.t : nx1 vector of time values t along solution
%   output.x : nx3 vector containing the solution for x(t) 
%              (e.g., output.x(:,2) is the solution for x2(t))
%   output.p : nx3 vector containing the solution for p(t)
%   output.X : 3x3xn matrix containing Jacobian of x(t) with respect to
%                  p(0) (e.g. output_IVP.X(:,:,10) is the jacobian
%                  output_IVP.x(10,:) with respect to a change in p0)
%   output.P : 3x3xn matrix containing the Jacobian of p(t) with
%                  p(0)
%   output.detX : 1xn vector containing determinant of J(t)
%   output.tconj : vector containing times of conjugate points
%   output.eta : error vector between desired value of x(1) and the
%                computed value of x(1)
%   output.err : norm of output.eta
%   output.p0 : initial condition p(0) found by BVP solver


% End of time interval
tf = 1;

% Initial condition for x(0)
x0 = [0 0 0]; 

% Desired boundary condition for x(tf)
xf = [0.3 0.3 0]; 

% Structure containing parameters (see parameters function below)
params = parameters; 

% Guess for initial condition p(0) 
p0 = [0 0 1]; 
% p0 = [0 0 -1]; 
% p0 = [0 0 5]; 
% p0 = [0 0 -5]; 
% p0 = [-200 4 8];

% Solve the boundary value problem
output = solve_BVP(x0,p0,xf,tf,params); 

% Plot solution
plot_function(output,xf)

end

