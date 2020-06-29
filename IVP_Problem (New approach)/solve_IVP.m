function output_IVP = solve_IVP(x0, p0,n ,L ,s,params)

% This function solves the IVP at the current value of p0
% Function Inputs:
%   x0 : initial condition for x(0) for every particle (nx3)
%        i th row is x1,x2,x3 position for i th particle
%   p0 : initial condition for p(0) for every particle (nx3)
%        i th row is p1,p2,p3 force for i th particle
%   s : end of rod interval (usually 1),scalar, as "time t"
%   n  : number of particles
%   L  : length of each rod
% Function Outputs:
%   output_IVP.t : tx1 vector of time values along solution, 
%                  a column vector
%   output_IVP.xi : txn vector of xi component for the n particles
%   output_IVP.pi : txn vector of pi component for the n particles

% Initial conditions, initialize Y0
Y0 = zeros(1,6*n);

%stores values of x and p in Y0
for i=1:n
    Y0(6*(i-1)+1:6*i) =  [x0(i,:) p0(i,:)];
end

% Solve ODEs by ode45
% [t,y] = ode45(odefun,tspan,y0,options)
% differential function dY : diff_eqns, accepts input t,Y
% time span : [0 s]
% Y0 : initial value of Y
% params.ode_options : error threshold
[t,sol] = ode45(@(t,Y) diff_eqns(t,Y,n,L,params),[0 s], Y0,params.ode_options);

% each row in the sol array y corresponds to 
% a value returned in column vector t.
% rearrange/transpose s.t. the ith row is the ith Y
solution = reshape(sol, [length(t),6*n]);

% Store vectors t, x, and p
output_IVP.t = t;
% x1 is to take the i th row 1st col x11, 7th col x21,...,till end
% and taking all possible rows i from 1 to end
% similarly for other variables
output_IVP.x1 = solution(:,1:6:end);
output_IVP.x2 = solution(:,2:6:end);
output_IVP.x3 = solution(:,3:6:end);

output_IVP.p1 = solution(:,4:6:end);
output_IVP.p2 = solution(:,5:6:end);
output_IVP.p3 = solution(:,6:6:end);

end









