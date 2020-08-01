function [output,distance,rbifur] = solve_continuation(x0,p0,n,L,s,Reqs, e,params,bifur_side)
    Dg = [];
    count = 0;
        Rbifur = [];
    average_d = [];
    dist = [];
    % iterate throgh all entries of Reqs
    for i=1:length(Reqs)

        % Set desired value for Req
        Req = Reqs(i);

        % Solve the boundary value problem
        output_BVP = solve_BVP(x0,p0,n,L,s,Req,e, params,bifur_side);

        % Store solution of boundary value problem at ith entry of output
        output(i) = output_BVP;

        % Update initial guess for p0,x0 and L
        x0 = output_BVP.x0;
        p0 = output_BVP.p0;
        L = output_BVP.L;
            dist = [dist output_BVP.distance];
fprintf('\n\n Det_Dg: %.10f ',output_BVP.det_Dg);
        
            % Print variables of interest
        % fprintf('\n\n iteration: %.0f of %.0f complete \n\n',i,length(BCs(:,1)))
        Dg = [Dg output_BVP.det_Dg];
        
    end
    Dg


    for i= 1:length(Dg)
        if i ~= length(Dg)
            if Dg(i) > 0 && Dg(i+1) <= 0
               Rbifur = [Rbifur Reqs(i)]
               average_d = [average_d dist(i)];
               
            elseif Dg(i) < 0 && Dg(i+1) >= 0
               Rbifur = [Rbifur Reqs(i)]
               average_d = [average_d dist(i)];
            end    
        end
    end

%figure(2)
%Plot solution
%c = 1;
%C = {'b-','k-','r-','g-','i-'};
%D = {'.b','.k','.r','.g','.i'};
%for i=1:length(Rbifur)
 %  scatter(average_d(i),e,"filled",'MarkerFaceColor',[0 0.5 0.5]);
  % hold on
   %Plot initial condition for x at t=0
    %Plot initial condition for x at t=L(i)
   %plot(output.x1(end,i),output.x2(end,i),D{i},'MarkerSize',10)
%Set axis limits
%Axis labels
%xlabel('Reqs')
%ylabel('Magnitude')
%end
distance = average_d
rbifur = Rbifur
%figure(3)
%plot(Reqs,average_d,color,'DisplayName',bifur_side);
%hold on
%xlabel('Reqs')
%ylabel('Distance between particles')



end

    