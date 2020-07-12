function G = error_boundary(config, n, L, Req)
%ERROR_BOUNDARY Summary of this function goes here
%   Detailed explanation goes here



g = sym(zeros(1,7*n-3));


%Order of variables will be 3n x0, 3n p0, 3n n L
variables = sym('x_%d',[1 7*n-3]);

Jac = jacobian(g,variables);

G(1:3) = variables( )

%Forces of the given config

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




bc2 = zeros(1,3*n-3);
for i=1:(n-1)
   G(:) =  
    
    
    
end



end

