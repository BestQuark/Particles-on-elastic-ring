function detX = find_detX(output)

% This function computes the determinant of X
% Function Inputs:
%   output : structure containing the current solution
% Function Outputs:
%   tc: time of first conjugate point

% Initialize detJ
detX = zeros(1,length(output.t));

% Compute detJ
for i=1:length(output.t)
    detX(i) = det(output.X(:,:,i));
end

end