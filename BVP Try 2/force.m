function Fij = force(xi,yi,xj,yj, Req)
%Force This function calculates the force excerted by two particles i and j
%over the ith particle (to obtain force on jth multiply by -1 output)
%   The input is position x and y of both ith and yith particle and Req
%   value

    Fij = zeros(1,2);
    
    syms x1 y1 x2 y2;
    Rij(x1,y1,x2,y2) = sqrt((x1-x2)^2 + (y1-y2)^2);
    
    %Springlike potential
    Vij(x1,y1,x2,y2) = (Rij(x1,y1,x2,y2) - Req)^2;

    %Lennard Jones potential
    %Vij(x1,y1,x2,y2) = epsilon* ((Req/Rij)^(12) - (Req/Rij)^6 );
    
    %Coulumblike potential
    %Vij(x1,y1,x2,y2) = -Rij(x1,y1,x2,y2)^(-1);
    
    %Calculates forces
    d1 = diff(Vij,x1);
    d2 = diff(Vij,y1);
    Fij(1) = d1(xi,yi,xj,yj);
    Fij(2) = d2(xi,yi,xj,yj);

end

