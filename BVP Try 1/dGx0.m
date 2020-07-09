function output = dGx0(output_IVP,n,forces)
%calculate dG/dx1
dG_x0 = zeros(7*n-3,6*n-3);

%Extracts data from output_IVP 
x0_x3 = output_IVP.x3(1,:)
x1_x3 = output_IVP.x3(end,:)
x0_p1 = output_IVP.p1(1,:)
x1_p1 = output_IVP.p1(end,:)
x0_p2 = output_IVP.p2(1,:)
x1_p2 = output_IVP.p2(end,:)
%for the first 3 element of G (derivatives) over x(0) (fixed at the origin)
%all 0 for the first 3 rows.

%for the next 3*(n-1) elements for the boundary conditions 
for i=1:n-1
        dG_x0(3*i+1:3*i+3,6*(i-1)+4: 6*i) = eye(3,3)
end

%for the boundary on p's 

for i = 1:n-1
        dG_x0(3*(n-1)+3*i+1:3*(n-1)+3*i+3,7+6*(i-1): 3+6*i) = eye(3,3)
end

%for the last func
for i=1:n-1
       %derivative over x3(0)
       dG_x0(6*(n-1)+3+i : 6*(n-1)+3+i,6+6*(i-1)) = -(x0_p1(i+1)-x1_p1(i))*sin(x0_x3(i+1)) + ...
                                                     (x0_p2(i+1) - x0_p2(i))*cos(x0_x3(i+1)) 
       %derivative over p(0)
       dG_x0(6*(n-1)+3+i:6*(n-1)+3+i,7+6*(i-1): 3+6*i) = [cos(x0_x3(i+1)) sin(x0_x3(i+1)) 0];
end


output = dG_x0

end

