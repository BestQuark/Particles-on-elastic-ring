function output = main_continuation_solver

% This function uses a shooting method to solve the boundary value problem
% for the following system:
% x1' = sin(x3)   x2' = cos(x3)   x3' = p3
% p1' = 0   p2' = 0   p3' = p1*sin(x3) - p2*cos(x3)
% Function Outputs:
%   (output(i) corresponds to the boundary condition in BCs(i,:))
%
%   output(i).t : nx1 vector of time values t along solution
%   output(i).x : nx3 vector containing the solution for x(t) 
%              (e.g., output.x(:,2) is the solution for x2(t))
%   output(i).p : nx3 vector containing the solution for p(t)
%   output(i).X : 3x3xn matrix containing Jacobian of x(t) with respect to
%                  p(0) (e.g. output_IVP.X(:,:,10) is the jacobian
%                  output_IVP.x(10,:) with respect to a change in p0)
%   output(i).P : 3x3xn matrix containing the Jacobian of p(t) with
%                  p(0)
%   output(i).detX : determinant of X(t)
%   output(i).tconj : time of first conjugate point
%   output(i).eta : error vector between desired value of x(1) and the
%                    computed value of x(1)
%   output(i).err : norm of output.eta
%   output(i).p0 : initial condition p(0) found by BVP solver

% End of time interval
tf = 1;

% Initial condition for x(0)
x0 = [0 0 0]; 

% List of Desired boundary condition for x(tf)
n = 50;
BCs = [0.5*ones(n,1) linspace(0,.5,n)' zeros(n,1)]; 

% Structure containing parameters (see parameters function below)
params = parameters; 

% Guess for initial condition p(0) 
p0 = [0 0 1]; 

% Solve the continuation problem
output = solve_continuation(x0,p0,BCs,tf,params);

end