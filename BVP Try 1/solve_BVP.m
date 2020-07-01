function output = solve_BVP(x0,p0,n,L,s,params)
%SOLVE_BVP Summary of this function goes here
%   Detailed explanation goes here


output_IVP = solve_IVP(x0,p0,n,L,s,params);

errorVector = error_for_BVP(output_IVP,L,n);

end

