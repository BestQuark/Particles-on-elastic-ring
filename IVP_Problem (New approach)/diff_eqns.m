function [dY] = diff_eqns(t,Y,n,L ,params)

% This function contains the differential equations we are solving
% Function Inputs:
%   t : current time
%   L : conditions on L (1xn vector),i th item is the i th length L(i)
%   Y : vector containing the solution at time t, Y is 1x6n vector
%       solutions include value of x and p for n particles
%   n : number of particles
%   params: parameter vector
% Function Outputs:
%   dY : dertivative of Y with respect to t (6nx1)

dY = zeros(1,n*6)';

for i=1:n
    x = Y(1+6*(i-1):3+6*(i-1));
    p = Y(4+6*(i-1):6+6*(i-1));
    u = p(3);
    
    %Compute derivatives
    %dx, dp is 1x3 matrix 
    dx = L(i)*[cos(x(3)) sin(x(3)) u];
    dp = L(i)*[0 0 p(1)*sin(x(3))-p(2)*cos(x(3))];
    
    %Store derivatives dx,dp in dY(6nx1)
    dY(6*(i-1)+1:6*i) = [dx dp]';

end



end