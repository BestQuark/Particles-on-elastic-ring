function [output,Out_Req] = find_det0_moveReq(x0,p0,n,L,s,Req,Vo, params)

% iterate through all entries of Reqs

    % Solve the boundary value problem
    output_BVP = solve_BVP(x0,p0,n,L,s,Req,Vo, params);
    
    % Update initial guess for p0,x0 and L
    x0 = output_BVP.x0;
    p0 = output_BVP.p0;
    L = output_BVP.L;
    detDg = output_BVP.detD;
    solved = 0;
    newReq = Req;
    dReq = 0.01*Req;
    try
        output_UP = solve_BVP(x0,p0,n,L,s,Req+dReq,Vo, params);
    catch
        output_UP.detD = 1e8;
    end
    
    try
        output_DOWN = solve_BVP(x0,p0,n,L,s,Req-dReq,Vo, params);
    catch
        output_DOWN.detD = 1e8;
    end
    
    if abs(detDg)<1e-2 || (abs(detDg)<abs(output_UP.detD) && abs(detDg)<abs(output_DOWN.detD))
        new_output=output_BVP;
        solved = 1;
    end
    
    if abs(output_UP.detD)<abs(output_DOWN.detD) && solved==0
        new_output = output_UP;
        currentD = output_UP.detD;
        increase = 1;
        while abs(currentD)>1e-2
            increase = increase+1;
            newReq = Req+increase*dReq;
            new_output = solve_BVP(x0,p0,n,L,s,newReq,Vo, params);
            currentD = new_output.detD;
            fprintf('iteration: %.0f ----   Req:%.10f ----  Determinant: %.10f  \n\n',increase,newReq, currentD)
          
            if increase>1e4
                error('find_det0_moveReq failed')
            end
        end
    elseif solved==0
        new_output = output_DOWN;
        currentD = output_DOWN.detD;
        increase = 1;
        while abs(currentD)>1e-2
            increase = increase+1;
            newReq = Req-increase*dReq;
            new_output = solve_BVP(x0,p0,n,L,s,newReq,Vo, params);
            currentD = new_output.detD;
            fprintf('\n\n iteration: %.0f ----   Req:%.10f ----  Determinant: %.10f  \n\n',increase,newReq, currentD)
    
                        
            if increase>1e4
                error('find_det0_moveReq failed')
            end
        end
    end
    
    output = new_output;
    Out_Req = newReq;
    

    
end

