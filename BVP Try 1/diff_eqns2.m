function dU = diff_eqns2(t,U,n,L ,params)

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


dY = zeros(1,n*6);

dM = zeros(6*n,7*n);

%Jacobian of f wrt x
Dxf = zeros(6*n);

%Jacobian of f wrt lambda (aka the longitudes L(i)) and 0 of size 6nx6n before so it doesn't affect v
Dlf = zeros(6*n,7*n);

%Matrix Y on notes (im gonna call it M)

M = reshape(U(6*n+1:end),6*n,7*n);

for i=1:n
    
    x = U(1+6*(i-1):3+6*(i-1));
    p = U(4+6*(i-1):6+6*(i-1));
    u = p(3);
    
    
    Dxif = [0 0 -L(i)*sin(x(3)) 0 0 0;...
           0 0 L(i)*cos(x(3)) 0 0 0;...
           0 0 0 0 0 L(i);...
           0 0 0 0 0 0;...
           0 0 0 0 0 0;...
           0 0 L(i)*(p(1)*cos(x(3))+p(2)*sin(x(3))) L(i)*sin(x(3)) -L(i)*cos(x(3)) 0];
    
    %Fills Dxf
    Dxf(6*(i-1)+1:6*i,6*(i-1)+1:6*i)= Dxif;
    
    Dlif = [cos(x(3)) sin(x(3)) p(3) 0 0 p(1)*sin(x(3))-p(2)*cos(x(3))]';
    
    %Fills Dlf
    Dlf(6*(i-1)+1:6*i,6*n+i)=Dlif;
        
    %Compute derivatives
    %dx, dp is 1x3 matrix 
    dx = L(i)*[cos(x(3)) sin(x(3)) u];
    dp = L(i)*[0 0 p(1)*sin(x(3))-p(2)*cos(x(3))];
    
    %Store derivatives dx,dp in dY(6nx1)
    dY(6*(i-1)+1:6*i) = [dx dp];
end


%Calculates dM as done in the notes
dM = Dxf*M + Dlf;

%Stores output vector
dU = [dY reshape(dM,1,[])]';
end