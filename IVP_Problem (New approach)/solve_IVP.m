function output_IVP = solve_IVP(x0, p0,n ,L ,s,params)

% This function solves the IVP at the current value of p0
% Function Inputs:
%   x0 : initial condition for x(0) for every particle (nx3)
%   p0 : initial condition for p(0) for every particle (nx3)
%   s : end of rod interval (usually 1)
%   n  : number of particles
%   L  : length of each rod
% Function Outputs:
%   output_IVP.t : tx1 vector of time values along solution
%   output_IVP.xi : txn vector of xi component for the n particles
%   output_IVP.pi : txn vector of pi component for the n particles


% Initial conditions 

Y0 = zeros(1,6*n);

for i=1:n
    Y0(6*(i-1)+1:6*i) =  [x0(i,:) p0(i,:)];
end


% Solve ODEs
[t,sol] = ode45(@(t,Y) diff_eqns(t,Y,n,L,params),[0 s], Y0,params.ode_options);

solution = reshape(sol, [length(t),6*n]);

% Store vectors t, x, and p
output_IVP.t = t;
output_IVP.x1 = solution(:,1:6:end);
output_IVP.x2 = solution(:,2:6:end);
output_IVP.x3 = solution(:,3:6:end);

output_IVP.p1 = solution(:,4:6:end);
output_IVP.p2 = solution(:,5:6:end);
output_IVP.p3 = solution(:,6:6:end);

end









