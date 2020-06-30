function output_Forces = forces(config,n,Req)
%FORCES Calculates forces between n particles
% Output: 2xn matrix where outputij is the ith component of the force on
% the jth particle
    syms xi yi xj yj
    
    syms x1 y1 x2 y2;
    Rij(x1,y1,x2,y2) = sqrt((x1-x2)^2 + (y1-y2)^2);
    
    %Springlike potential
    Vij(x1,y1,x2,y2) = (Rij(x1,y1,x2,y2) - Req)^2;

    %Lennard Jones potential
    %Vij(x1,y1,x2,y2) = 0.3* ((Req/Rij)^(12) - (Req/Rij)^6 );
    
    %Coulumblike potential
    %Vij(x1,y1,x2,y2) = -Rij(x1,y1,x2,y2)^(-1);
    
    %Calculates forces
    d1 = diff(Vij,x1);
    d2 = diff(Vij,y1);


    f(xi,yi,xj,yj) = [d1(xi,yi,xj,yj) d2(xi,yi,xj,yj)];

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

