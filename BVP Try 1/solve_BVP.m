function output_BVP = solve_BVP(x0,p0,n,L,s,Req, params)
% This function contains the main loop used to solve the BVP using a
% shooting method
% Function Inputs:
%   x0 : initial condition for x(0)
%   p0 : guess for initial condition p(0) 
%   n  : number of particles
%   s  : length interval
%   L  : length for every rod
%   params : structure containing parameters
% Function Outputs:



while i <= params.nmax 
    i = i+1;
    
    output_IVP = solve_IVP2(x0,p0,n,L,s,params);
    Gvector = error_for_BVP(output_IVP,L,n,Req);
    Gnorm = norm(Gvector);

    plot_function(output_IVP,n);

    if Gnorm <= params.tol
        output_BVP = output_IVP;
        output_BVP.p0 = p0;
        break
    end
    
    %These "some_functions" must be replaced with the real functions
    dG_x0 = some_function(output_IVP,L,n,Req) ;
    dG_x1 = some_function2(output_IVP,L,n,Req);
    dG_lambda = some_funtion3(output_IVP,L,n);
    
    Dg_x0 = dG_x0 + dG_x1*(output_IVP.V1(4:end,4:end));
    Dg_lambda = dG_lambda + dG_x1*(output_IVP.W1(4:end,:));
    
    Dg = zeros(7*n-3);
    Dg(:,1:6*n-3) = Dg_x0 ; %Put Dg_x0
    Dg(:,6*n-2:end) = Dg_lambda; %Dg_lambda
    
    %update parameters
    dV = -Dg\Gvector;
    
    
    %Puts conditions as column vector size 7n-3
    initial_conditions = zeros(7*n-3,1);
    
    initial_conditions(1:3) = p0(1,:)';
    
    for i=2:n
       initial_conditions(4+6*(i-2):4+6*(i-1)) = [x0(i,:) p0(i,:)]';
    end
    
    initial_conditions(6*n-2:end) = L;
    
    %Updates initial conditions
    %Without line search
    initial_conditions = initial_conditions - dV;
    
    %Puts (new) conditions again as they should be
    
    p0(1,:) = initial_conditions(1:3);
    for i=2:n
       x0(i,:) = initial_conditions(4+6*(i-2):1+6*(i-1))';
       p0(i,:) = initial_conditions(7+6*(i-2):4+6*(i-1))';
    end
    
    L = initial_conditions(6*n-2:end);

end

end

