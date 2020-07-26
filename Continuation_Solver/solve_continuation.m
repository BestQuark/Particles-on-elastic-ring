function output = solve_continuation(x0,p0,BCs,tf,params)

% This function contains the main loop used to solve the continuation
% problem
% Function Inputs:
%   x0 : initial condition for x(0)
%   p0 : guess for initial condition p(0) 
%   BCs : list of desired boundary condition for x(tf)
%   tf : end of time interval
%   params : structure containing parameters
% Function Outputs:
%   output_BVP.t : nx1 vector of time values t along solution
%   output_BVP.x : nx3 vector containing the solution for x(t) 
%              (e.g., output.x(:,2) is the solution for x2(t))
%   output_BVP.p : nx3 vector containing the solution for p(t)
%   output_BVP.X : 3x3xn matrix containing Jacobian of x(t) with respect to
%                  p(0) (e.g. output_IVP.X(:,:,10) is the jacobian
%                  output_IVP.x(10,:) with respect to a change in p0)
%   output_BVP.P : 3x3xn matrix containing the Jacobian of p(t) with
%                  p(0)
%   output_BVP.detX : determinant of X(t)
%   output_BVP.tconj : time of first conjugate point
%   output_BVP.eta : error vector between desired value of x(1) and the
%                    computed value of x(1)
%   output_BVP.err : norm of output.eta
%   output_BVP.p0 : initial condition p(0) found by BVP solver

for i=1:length(BCs(:,1))
   
    % Set desired boundary conditions
    xf = BCs(i,:);
    
    % Solve the boundary value problem
    output_BVP = solve_BVP(x0,p0,xf,tf,params);
    
    % Store solution of boundary value problem
    output(i) = output_BVP;

    % Update initial guess for p0
    p0 = output_BVP.p0;
    
    % Print variables of interest
    fprintf('\n\n iteration: %.0f of %.0f complete \n\n',i,length(BCs(:,1)))
    
end

end