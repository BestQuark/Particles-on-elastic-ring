function output = dGlambda(output_IVP,n)
%Calculates dGlambda

dGl = zeros(7*n-3,n);
dGl(end,:) = ones(1,n);
output = dGl;


end

