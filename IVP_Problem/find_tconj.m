function tconj = find_tconj(output,params)

% This function computes the first conjugate point (the first positive time
% when det(X(t))=0 for t in (0,tf)
% Function Inputs:
%   output : structure containing the current solution
% Function Outputs:
%   tconj: time of first conjugate point

tconj = [];
start_ind = find(abs(output.detX) > params.detXtol,1,'first');

for i = start_ind:length(output.t)
    
    if output.detX(i)*output.detX(i-1) <= 0
        tconj = output.t(i);
        break
    end
    
end

end