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

output_IVP = solve_IVP2(x0,p0,n,L,s,params);
Gvector = error_for_BVP(output_IVP,L,n,Req);
Gnorm = norm(Gvector);

while i <= params.nmax 
    i = i+1;

    % Print variables of interest
    fprintf('iteration: %.0f     error: %.10f \n',i,Gnorm)
    
    plot_function(output_IVP,n);

    if Gnorm <= params.tol
        output_BVP = output_IVP;
        output_BVP.x0 = x0;
        output_BVP.p0 = p0;
        output_BVP.L = L;
        break
    end
    
    %These "some_functions" must be replaced with the real functions
    dG_x0 = some_function(output_IVP,L,n,Req) ;
    dG_x1 = dGx1(output_IVP,n);
    dG_lambda = dGlambda(output_IVP,n);
    
    Dg_x0 = dG_x0 + dG_x1*(output_IVP.V1(4:end,4:end));
    Dg_lambda = dG_lambda + dG_x1*(output_IVP.W1(4:end,:));
    
    Dg = zeros(7*n-3);
    Dg(:,1:6*n-3) = Dg_x0 ; %Put Dg_x0
    Dg(:,6*n-2:end) = Dg_lambda; %Dg_lambda
    
    %update parameters
    dV = -Dg\Gvector;
    
    % Enforce maximum step size
    if norm(dV) > params.maxstep
        dV = dV/norm(dV)*params.maxstep;
    end
   
    %Puts conditions as column vector size 7n-3
    initial_conditions = zeros(7*n-3,1);
    
    initial_conditions(1:3) = p0(1,:)';
    
    for i=2:n
            initial_conditions(4+6*(i-2):4+6*(i-1)) = [x0(i,:) p0(i,:)]';
    end
    
    initial_conditions(6*n-2:end) = L;
    
    %L2 = zeros(1,n);
    %Initializes x02 and p02 beforehand
    x02 = zeros(3,n);
    p02 = zeros(3,n);
    
    condition = 1;
    %Line search method
    while condition==1
    
    %Updates initial conditions
        initial_conditions2 = initial_conditions - dV;
    
    %Puts (new) conditions again as they should be
    
        p02(1,:) = initial_conditions2(1:3);
        for i=2:n
            x02(i,:) = initial_conditions2(4+6*(i-2):1+6*(i-1))';
            p02(i,:) = initial_conditions2(7+6*(i-2):4+6*(i-1))';
        end
    
        L2 = initial_conditions2(6*n-2:end);
        
        output_IVP2 = solve_IVP2(x02,p02,n,L2,s,params);
        Gvector2 = error_for_BVP(output_IVP2,L2,n,Req);
        Gnorm2 = norm(Gvector2);
        
        if Gnorm>Gnorm2
            condition=0;
            L = L2;
            x0 = x02;
            p0 = p02;
            output_IVP = output_IVP2;
            Gvector = Gverctor2;
            Gnorm = Gnorm2;
        elseif norm(dV)>1e-8
            dV = dV/2;
        else
            error('Line search failed')
        end
        
    end
end

if Gnorm > params.tol
    error('BVP solver failed')
end

end



