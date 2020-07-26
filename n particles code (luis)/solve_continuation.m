function [output] = solve_continuation(x0,p0,n,L,s,Reqs,Vos, params)

% iterate through all entries of Reqs
LREQ = length(Reqs);
filename1 = 'ThreeParticles_SECONDBIFFURCATION_All2_V=1000.gif';
    for i=1:LREQ
   
    % Set desired value for Req
    Req = Reqs(i);
    Vo  = Vos(1);
    
    % Solve the boundary value problem
    output_BVP = solve_BVP(x0,p0,n,L,s,Req,Vo, params);
    
    % Store solution of boundary value problem at ith entry of output
    output(i) = output_BVP;

    % Update initial guess for p0,x0 and L
    x0 = output_BVP.x0;
    p0 = output_BVP.p0;
    L = output_BVP.L;
    detDg = output_BVP.detD;

    
%     if detDg<1e-5
%         biffs = biffs+1;
%         biffurcations.R = Req;
%         biffurcations.V = Vo;
%     end

%Makes GIF
%     frame1 = getframe(output_BVP.plot);
%     im1 = frame2im(frame1);
%     [imind1,cm1] = rgb2ind(im1,256);
%     if i == 1
%         imwrite(imind1,cm1,filename1,'gif', 'Loopcount',inf,'DelayTime',0.2);
%     else
%         imwrite(imind1,cm1,filename1,'gif','WriteMode','append','DelayTime',0.2);
%     end
%     % Print variables of interest
      fprintf('\n\n iteration: %.0f ----   Req:%.10f ----  Determinant: %.10f  \n\n',i,Req, detDg)
%     
     end
    
    %snake in Req
    %Reqs = fliplr(Reqs);
    
end

