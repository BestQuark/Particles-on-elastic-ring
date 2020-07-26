function output_Forces = forces(config,n,Req,Vo,params)
%Input:
% config: configurations of the particles, a struct stores x1,x2,x3
%          p1,p2,p3...info
% n:number of particles
% Req: a constant of equilibrium distance, pre-assumed
% params: used for getting values of coefficients in different
%             potential formulas
% FORCES Calculates forces between n particles
% Output: 
% output_Forces.F:  2xn matrix where 
% output_Forcesij is the ith component of the force on
% the jth particle
% output_Forces.A: 4xn matrix First component is dx1 of F_1, second component
% is dx2 of F_1, thirdcomponent is dx1 of F_2, fourth component
% is dx2 of F_2

   % symbolic values of locations (x,y)
   % along direction x1,y1, and x2,y2, only 2 directions
   
    syms xi yi xj yj
    syms x1 y1 x2 y2;
    % distance Rij btw i,j particle
    Rij(x1,y1,x2,y2) = sqrt((x1-x2)^2 + (y1-y2)^2);
    
    % Case 1: Springlike potential proportional to d^2
    % Req a constant
    Vij(x1,y1,x2,y2) = Vo*(Rij(x1,y1,x2,y2) - Req)^2;

    
    
    % Case 2: Lennard Jones potential
    % assume epsilon = 0.3
    
     %epsilon = params.LJ_potential_epsilon;
     %Vij(x1,y1,x2,y2) = epsilon * ((Req/Rij(x1,y1,x2,y2))^(12) - (Req/Rij(x1,y1,x2,y2))^6);
    
    
 
    % Case 3: Coulumblike potential, inverse of d^2
    % that makes sense, changed back with a coefficient k
    % k * 1/Rij
    
     %k = params.Coulumb_potential_coefficient;
    % Vij(x1,y1,x2,y2) = k * (1/Rij(x1,y1,x2,y2));
   
    
    
    
    % Case 4: a random class-mentioned potential with 1/(d^2)
    % not sure for realistic examples...
    
    % Vij(x1,y1,x2,y2) = 1/((Rij(x1,y1,x2,y2)-Req)^2);
    
    % Calculates forces
    % force is derivative of potential
    d1 = diff(Vij,x1);
    d2 = diff(Vij,y1);
    
    a11 = diff(d1,x2);
    a12 = diff(d1,y2);
    a21 = diff(d2,x2);
    a22 = diff(d2,y2);
    
    a11n = diff(d1,x1);
    a12n = diff(d1,y1);
    a21n = diff(d2,x1);
    a22n = diff(d2,y1);

    %dV/dj
    f(xi,yi,xj,yj) = [d1(xi,yi,xj,yj); d2(xi,yi,xj,yj)];
    
    %ddV/djdj
    a(xi,yi,xj,yj) = [a11(xi,yi,xj,yj) a12(xi,yi,xj,yj);...
                      a21(xi,yi,xj,yj) a22(xi,yi,xj,yj)];
     
    %ddV/didj             
    an(xi,yi,xj,yj) = [a11n(xi,yi,xj,yj) a12n(xi,yi,xj,yj);...
                      a21n(xi,yi,xj,yj) a22n(xi,yi,xj,yj)];
    
    % initialize output_Forces
    output_Forces.F = zeros(2,n);
    output_Forces.A = zeros(2*n,2*n);
    output_Forces.Rij = zeros(n,n);

for i=1:n
    for j=1:n
          if i~=j
             %calculates force
             Fij =f(config.x1(1,i),config.x2(1,i),config.x1(1,j),config.x2(1,j));             
             output_Forces.F(:,i) = output_Forces.F(:,i) + Fij;

             %output distances between particles
             Distanceij = Rij(config.x1(1,i),config.x2(1,i),config.x1(1,j),config.x2(1,j));
             output_Forces.Rij(i,j) = Distanceij;
             
             %Make a matrix 2n x 2n to store in block of 2x2 the second
             %partials of SUM(Vij)
             output_Forces.A(2*(i-1)+1:2*(i-1)+2,2*(j-1)+1:2*(j-1)+2) = a(config.x1(1,i),config.x2(1,i),config.x1(1,j),config.x2(1,j));
             
          else  
            for k=1:n
                 if k~=i
                     %calculates dSUM(dVij) in diagonal
                     Aij = an(config.x1(1,j),config.x2(1,j),config.x1(1,k),config.x2(1,k));               
                     output_Forces.A(2*(i-1)+1:2*(i-1)+2,2*(j-1)+1:2*(j-1)+2) = output_Forces.A(2*(i-1)+1:2*(i-1)+2,2*(j-1)+1:2*(j-1)+2) + Aij;
                 end
            end
          end
    end  
end

end

