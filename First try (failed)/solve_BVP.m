function output_BVP = solve_BVP(x0,p0,s,xf,tf,params)

% This function contains the main loop used to solve the BVP using a
% shooting method
% Function Inputs:
%   x0 : initial condition for x(0)
%   p0 : guess for initial condition p(0) 
%   xf : desired boundary condition for x(tf)
%   tf : end of time interval
%   params : structure containing parameters
% Function Outputs:
%   output_BVP.t : nx1 vector of time values along solution
%   output_BVP.x : nx3 matrix containing the solution for x(t)
%                  (e.g., output_IVP.x(:,2) is the solution for x_2(t)) 
%   output_BVP.p : nx3 matrix containing the solution for p(t)
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


%% Initialize counter and output
i = 0;
output_BVP = [];

%% Boundary value problem loop
while i <= params.nmax 
    
    % Iterate counter
    i = i+1;
     
    % Solve IVP
    output_IVP = solve_IVP_Particles(x0,p0,s,tf,params);
    
    % Store error between current and desired value of x(tf)
    output_IVP.eta = [output_IVP.x(end,1)-xf(1)... 
                      output_IVP.x(end,2)-xf(2)...
                      wrapToPi(output_IVP.x(end,3)-xf(3))];
    output_IVP.err = norm(output_IVP.eta);
    
    % Print variables of interest
    fprintf('iteration: %.0f     error: %.10f \n',i,output_IVP.err)
    
    % Plot solution
    plot_function(output_IVP);
    
    % Check if error tolerance is satisfied
    if output_IVP.err <= params.tol
        output_BVP = output_IVP;
        output_BVP.p0 = p0;
        break
    end
    
    % Compute search direction for p0
    jacobian = output_IVP.X(:,:,end);
    dp0 = -jacobian\output_IVP.eta'; % this is equivalent to 
                                     % -inv(jacobian)*output_IVP.eta'
    
    % Enforce maximum step size
    if norm(dp0) > params.maxstep
        dp0 = dp0/norm(dp0)*params.maxstep;
    end
    
    % Update p0
    p0 = p0+dp0';
    
end

if output_IVP.err > params.tol
    error('BVP solver failed')
end

end
