function output = main_IVP_solver

% This function uses solves the initial value problem 
% for the following system:
% x1' = sin(x3)   x2' = cos(x3)   x3' = p3
% p1' = 0   p2' = 0   p3' = p1*sin(x3) - p2*cos(x3)
% Function Outputs:
%   output.t : nx1 vector of time values t along solution
%   output.x : nx3 vector containing the solution for x(t) 
%              (e.g., output.x(:,2) is the solution for x2(t))
%   output.p : nx3 vector containing the solution for p(t)
%   output_IVP.X : 3x3xn matrix containting Jacobian of x(t) with respect to p(0)
%              (e.g., output.X(:,:,10) is the jacobian of output.x(10,:)
%              with respect to a change in output.p(1,:))
%   output_IVP.P : Jacobian of p(t) with respect to p(0)
%   output.tconj : vector containing times of conjugate points

% Initial conditions for x and p
x0 = [0 0 0];
p0 = [1 1 1];

% Final time
tf = 1;
s = 0.5;

% Define parameters
params = parameters;

% Solve IVP
%ROD 1
output1 = solve_IVP(x0,p0,s,params);

%ROD 2
F = [1 1 0];
x0_2 = output1.x(end,:);
p0_2 = output1.p(end,:) + F;

output2 = solve_IVP(x0_2,p0_2,tf-s,params);

% Plot solution
plot(output1.x(:,1), output1.x(:,2),output2.x(:,1), output2.x(:,2));

%plot_function(output1,[output1.x(end,1) output1.x(end,2)])
%plot_function(output2,[output2.x(end,1) output2.x(end,2)])


end