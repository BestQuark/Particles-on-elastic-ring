function output_BVP = solve_BVP(x0,p0,n,L,s,Req,Vo, params)
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
Gvector = error_for_BVP(output_IVP,L,n,Req,Vo,params);

%Moves vector on second biffurcation by vector in kernel of Dg
%FIRST BIFF 3 PARTICLES
% if Req< 0.25 && Req>0.24
%     Gvector = Gvector - 100*[0.3692   -0.5700   -0.0841   -0.0010    0.0010    0.0178   -0.4467    0.2943    0.0272   -0.0005   -0.0001   -0.0066   0.3807    0.3095    0.0616    0.0020   -0.0029    0.0009];
% end

%SECOND BIFFURCATIONS OF 3 PARTICLE CASE
% if Req< 0.07 && Req>0.06
%     Gvector = Gvector - 100*[0.3692   -0.5700   -0.0841   -0.0010    0.0010    0.0178   -0.4467    0.2943    0.0272   -0.0005   -0.0001   -0.0066   0.3807    0.3095    0.0616    0.0020   -0.0029    0.0009];
% end

% if Req< 0.07 && Req>0.06
%     Gvector = Gvector + 100*[0.0159   -0.5406    0.0108   -0.0001    0.0001   -0.0001    0.0234   -0.4973    0.0206   -0.0001   -0.0002    0.0002    -0.0149   -0.6774   -0.0052   -0.0019    0.0000    0.0019];
% end
Gnorm = norm(Gvector);

counter=0;

while counter <= params.nmax 
    counter = counter+1;
    
    % Print variables of interest
    fprintf('iteration: %.0f     error: %.10f \n',counter,Gnorm)
    
    force = forces(output_IVP,n,Req,Vo,params);
    %These "some_functions" must be replaced with the real functions
    dG_x0 = dGx0(output_IVP,n,force); 
    dG_x1 = dGx1(output_IVP,n);
    dG_lambda = dGlambda(output_IVP,n);
    
    Dg_x0 = dG_x0 + dG_x1*(output_IVP.V1(:,4:end));
    Dg_lambda = dG_lambda + dG_x1*(output_IVP.W1);
    
    Dg = zeros(7*n-3);
    Dg(:,1:6*n-3) = Dg_x0 ; %Put Dg_x0
    Dg(:,6*n-2:end) = Dg_lambda; %Dg_lambda
    
    drawnow
    if Gnorm <= params.tol
        output_BVP = output_IVP;
        output_BVP.x0 = x0;
        output_BVP.p0 = p0;
        output_BVP.L = L;
        output_BVP.Rij = force.Rij;
        output_BVP.dg = Dg;
        determinantDg = det(Dg);
        output_BVP.detD = determinantDg;
        output_BVP.plot = plot_function(output_IVP,n);
        break
    end
    
    %update parameters
    dV = -Dg\Gvector';
    
    % Enforce maximum step size
    if norm(dV) > params.maxstep
       dV = dV/norm(dV)*params.maxstep;
    end
   
    %Puts conditions as column vector size 7n-3
    initial_conditions = zeros(7*n-3,1);
    
    initial_conditions(1:3) = p0(1,:)';
    
    for i=2:n
            initial_conditions(4+6*(i-2):3+6*(i-1)) = [x0(i,:) p0(i,:)]';
    end
    
    initial_conditions(6*n-2:end) = L;
    
    %L2 = zeros(1,n);
    %Initializes x02 and p02 beforehand
    x02 = zeros(n,3);
    p02 = zeros(n,3);
    
    condition = 1;
    %Line search method
    while condition==1
    
    %Updates initial conditions
        initial_conditions2 = initial_conditions + dV;
    
    %Puts (new) conditions again as they should be
    
        p02(1,:) = initial_conditions2(1:3);
        for i=2:n
            x02(i,:) = initial_conditions2(4+6*(i-2):6+6*(i-2))';
            p02(i,:) = initial_conditions2(7+6*(i-2):9+6*(i-2))';
        end
    
        L2 = initial_conditions2(6*n-2:end);
        
        
        output_IVP2 = solve_IVP2(x02,p02,n,L2,s,params);
        Gvector2 = error_for_BVP(output_IVP2,L2,n,Req,Vo,params);
        Gnorm2 = norm(Gvector2);
        %Gnorm2<Gnorm ||counter==1||counter==2
        if Gnorm2<Gnorm ||counter==1
            condition=0;
            L = L2;
            x0 = x02;
            p0 = p02;
            output_IVP = output_IVP2;
            Gvector = Gvector2;
            Gnorm = Gnorm2;
        elseif norm(dV)>1e-7
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



