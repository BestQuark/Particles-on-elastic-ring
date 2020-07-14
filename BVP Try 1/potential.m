
function Vij = potential(xi,xj,Req)
%POTENTIAL Summary of this function goes here
%   Detailed explanation goes here
    Rij = sqrt((xi(1)-xj(1))^2 + (xi(2)-xj(2))^2);
    %First potential
    Vij = (Rij - Req)^2;
    %Lennard Jones potential
    % Vij = epsilon*( (Req/Rij)^(12) - (Req/Rij)^6 );
    
end

