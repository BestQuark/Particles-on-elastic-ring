function output_IVP = solve_IVP(x0,p0,tf,params)

% This function solves the IVP at the current value of p0
% Function Inputs:
%   x0 : initial condition for x(0) for every particle (nx3)
%        i th row is x1,x2,x3 position for i th particle
%   p0 : initial condition for p(0) for every particle (nx3)
%        i th row is p1,p2,p3 force for i th particle
%   tf : end of time interval,
%        also refers to s:= the end of rod interval(usually 1)
% Function Outputs:
%   output_IVP.t : nx1 vector of time values along solution
%   output_IVP.x : nx3 matrix containing the solution for x(t)
%                  (e.g., output_IVP.x(:,2) is the solution for x_2(t)) 
%   output_IVP.p : nx3 matrix containing the solution for p(t)
%   output_IVP.X : 3x3xn matrix containing Jacobian of x(t) with respect to
%                  p(0) (e.g. output_IVP.X(:,:,10) is the jacobian
%                  output_IVP.x(10,:) with respect to a change in p0)
%   output_IVP.P : 3x3xn matrix containing the Jacobian of p(t) with
%                  p(0)
%   output_IVP.detX : determinant of X(t)
%   output_IVP.tconj : time of first conjugate point

% Initial conditions for Jacobian matrices X(t) and P(t)
X0 = zeros(3,3);
P0 = eye(3);

% Initial condition vector
Y0 = [x0 p0 reshape(X0',1,9) reshape(P0',1,9)];

% Solve ODEs
[t,sol] = ode45(@(t,Y) diff_eqns(t,Y,params),[0 tf],Y0,params.ode_options);

% Store vectors t, x, and pol
output_IVP.t = t;
output_IVP.x = sol(:,1:3);
output_IVP.p = sol(:,4:6);

% Store Jacobian matrices
output_IVP.X = permute(reshape(sol(:,7:15)',3,3,length(t)),[2,1,3]);
output_IVP.P = permute(reshape(sol(:,16:24)',3,3,length(t)),[2,1,3]);

% Store values of detX and times of conjugate points
output_IVP.detX = find_detX(output_IVP);
output_IVP.tconj = find_tconj(output_IVP,params);

end









