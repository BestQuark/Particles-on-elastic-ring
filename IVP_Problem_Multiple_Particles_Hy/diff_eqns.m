function dY = diff_eqns(t,Y,params)

% This function contains the differential equations we are solving
% Function Inputs:
%   t : current time
%   Y : vector containing the solution at time t
%   params: parameter vector
% Function Outputs:
%   dY : dertivative of Y with respect to t

% Get vectors x and p
x = Y(1:3);
p = Y(4:6);

% Get jacobian matrices X and P
X = reshape(Y(7:15),3,3)';
P = reshape(Y(16:24),3,3)';

% Define control input u in terms of x and p
u = p(3);

% Compute derivatives of x and p
dx = [cos(x(3)) sin(x(3)) u];
dp = [0 0 p(1)*sin(x(3))-p(2)*cos(x(3))];

% Compute coefficient matices for conjugate point test
Hxx = [0 0 0;...
       0 0 0;...
       0 0 -p(1)*cos(x(3))-p(2)*sin(x(3))];
   
Hpp = [0 0 0;...
       0 0 0;...
       0 0 1];
   
Hxp = [0 0 -sin(x(3));...
       0 0 cos(x(3));...
       0 0 0];
   
Hpx = Hxp';

% Compute derivatives of matrices X and P
dX = Hpp*P+Hxp*X;
dP = -Hpx*P-Hxx*X;

% Store derivatives
dY = [dx dp reshape(dX',1,9) reshape(dP',1,9)]';

end