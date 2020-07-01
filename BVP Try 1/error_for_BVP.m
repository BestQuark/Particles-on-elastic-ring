function G = error_for_BVP(config,L,n)
%ERROR_FOR_BVP Summary of this function goes here
%   Detailed explanation goes here

G = zeros(1,7*n-3);

%Extracts data from config for easier use
initial_rod.x1 = config.x1(1,:);
initial_rod.x2 = config.x2(1,:);
initial_rod.x3 = config.x3(1,:);
initial_rod.p1 = config.p1(1,:);
initial_rod.p2 = config.p2(1,:);
initial_rod.p3 = config.p3(1,:);

end_rod.x1 = config.x1(end,:);
end_rod.x2 = config.x2(end,:);
end_rod.x3 = config.x3(end,:);
end_rod.p1 = config.p1(end,:);
end_rod.p2 = config.p2(end,:);
end_rod.p3 = config.p3(end,:);

Forces = forces(initial_rod,n, Req);


%first bc
G(1) = end_rod.x1(end) ;
G(2) = end_rod.x2(end) ;
G(3) = end_rod.x3(end) ;


%bc on x0 - xf
for i=1:(n-1)
   G(4+3*(i-1)) = initial_rod.x1(i+1) - end_rod.x1(i);
   G(5+3*(i-1)) = initial_rod.x2(i+1) - end_rod.x2(i);
   G(6+3*(i-1)) = initial_rod.x3(i+1) - end_rod.x3(i);
end
%3n first components full
%bc on p's

for i=2:n
    G(3*n+1+3*(i-2)) = initial_rod.p1(i)-end_rod.p1(i-1)-Forces(1,i);
    G(3*n+2+3*(i-2)) = initial_rod.p2(i)-end_rod.p2(i-1)-Forces(2,i);
    G(3*n+3+3*(i-2)) = initial_rod.p3(i)-end_rod.p3(i-1);
end

%6n-3 conditions

for i=1:(n-1)
   G(6*n-3+i) = (initial_rod.p1(i+1)-end_rod.p1(i))*cos(initial_rod.x3(i+1)) +(initial_rod.p2(i+1)-end_rod.p2(i))*sin(initial_rod.x3(i+1)) ;
end

G(end) = sum(L)-1;


end

