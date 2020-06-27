function potentials = particle_potentials(config,n, Req)
%This function calculates the potential at every particle configuration
% I don't think we will use this since we already have particle_forces.m
% I didn't used it since it is less effective using this function to
% calculate all potentials if we only care for the derivative of V at a certain
% particle.

%Anyways I include it just in case

% Output: potentials is a 1xn vector where potentials(i) is the ith value
% of the potential 

% Inputs: config is the current configuration of the particles and rod
%         n is the number of particles
%         Req is the parameter we will vary to find bifurcations

potentials = zeros(1,n);

for i = 1:(n-1)
    for j = (i+1):n
        Rij = sqrt((config.x1(i)-config.x1(j))^2 + (config.x2(i)-config.x2(j))^2);

        %First potential
        Vij = (Rij - Req)^2;
        %Lennard Jones potential
        % Vij = epsilon*( (Req/Rij)^(12) - (Req/Rij)^6 );
        
        potentials(i) = potentials(i) + Vij;
        potentials(j) = potentials(j) + Vij;
    end

end

