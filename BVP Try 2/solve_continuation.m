function output = solve_continuation(x0,p0,n,L,s,Reqs, params)

for i=1:length(Reqs)
   
    % Set desired value for Req
    Req = Reqs(i)
    
    % Solve the boundary value problem
    output_BVP = solve_BVP(x0,p0,n,L,s,Req, params);
    
    % Store solution of boundary value problem
    output(i) = output_BVP;

    % Update initial guess for p0,x0 and L
    x0 = output_BVP.x0;
    p0 = output_BVP.p0;
    L = output_BVP.L;
    
    % Print variables of interest
   % fprintf('\n\n iteration: %.0f of %.0f complete \n\n',i,length(BCs(:,1)))
    
end

end