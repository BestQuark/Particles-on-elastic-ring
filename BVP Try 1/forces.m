function output_Forces = forces(config,n,Req,params)
%Input:
% config: configurations of the particles, a struct stores x1,x2,x3
%          p1,p2,p3...info
% n:number of particles
% Req: a constant of equilibrium distance, pre-assumed
% params: used for getting values of coefficients in different
%             potential formulas
% FORCES Calculates forces between n particles
% Output: 
% output_Forces:  2xn matrix where 
% output_Forcesij is the ith component of the force on
% the jth particle

   % symbolic values of locations (x,y)
    syms xi yi xj yj
    syms x1 y1 x2 y2;
    %distance Rij btw i,j particle
    Rij(x1,y1,x2,y2) = sqrt((x1-x2)^2 + (y1-y2)^2);
    
    %Springlike potential proportional to d^2
    %Req a constant
    Vij(x1,y1,x2,y2) = (Rij(x1,y1,x2,y2) - Req)^2;

    %Lennard Jones potential
    % assume epsilon = 0.3
    
    %epsilon = params.LJepsilon;
    %Vij(x1,y1,x2,y2) = epsilon * ((Req/Rij(x1,y1,x2,y2))^(12) - (Req/Rij(x1,y1,x2,y2))^6);
    
    %Coulumblike potential, inverse of d^2
    %original formula: Vij(x1,y1,x2,y2) = -Rij(x1,y1,x2,y2)^(-1);
    % a more general update of Vij,need 1/(d^2) not 1/d:
    % d = Rij(x1,y1,x2,y2) - Req;
    % Vij(x1,y1,x2,y2) = 1/((Rij(x1,y1,x2,y2)-Req)^1);
    
    %Calculates forces
    d1 = diff(Vij,x1);
    d2 = diff(Vij,y1);

    f(xi,yi,xj,yj) = -[d1(xi,yi,xj,yj) d2(xi,yi,xj,yj)];

    output_Forces = zeros(2,n);

for i=1:n
    for j=i:n
          if i~=j
             Fij =f(config.x1(i),config.x2(i),config.x1(j),config.x2(j))';
             output_Forces(:,i) = output_Forces(:,i)+Fij;
             output_Forces(:,j) = output_Forces(:,j)-Fij;
          end  
    end  
end

end

