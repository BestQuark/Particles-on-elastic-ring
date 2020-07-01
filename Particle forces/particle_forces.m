function output_Forces = particle_forces(config,n, Req)
%PARTICLE_FORCES Summary of this function goes here
%   For a given configuration of particles it calculates the forces acting
%   on them
%   Input: config.x1(i) must give the x1 component of the ith particle
%          config.x2(i) must give the x2 component of the ith particle
%   Outputs:
%       output_Forces 3xn where output_Forces(:,i) is the force over the
%       ith particle
output_Forces = zeros(2,n);

dx = 0.0001;

for i = 1:n
    potential = 0;
    d1potential =0;
    d2potential =0;
    
    for j = 1:n
        if i~=j
        Rij = sqrt((config.x1(i)-config.x1(j))^2 + (config.x2(i)-config.x2(j))^2);
        
        d1Rij = sqrt((config.x1(i)+dx-config.x1(j))^2 + (config.x2(i)-config.x2(j))^2);
        d2Rij = sqrt((config.x1(i)-config.x1(j))^2 + (config.x2(i)+dx-config.x2(j))^2);
        %First potential
        Vij = (Rij - Req)^2;
        d1Vij = (d1Rij - Req)^2;
        d2Vij = (d2Rij - Req)^2;
        
        %Lennard Jones potential
        % Vij = epsilon*( (Req/Rij)^(12) - (Req/Rij)^6 );
        
        potential = potential + Vij;
        d1potential = d1potential + d1Vij;           
        d2potential = d2potential + d2Vij;
            
        end
    end
    
    output_Forces(1,i) = (-potential + d1potential)/dx;
    output_Forces(2,i) = (-potential + d2potential)/dx; 
end





end

