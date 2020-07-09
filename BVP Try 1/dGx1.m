function output = dGx1(output_IVP,n)
%calculate dG/dx1
dG_x1 = zeros(7*n-3,6*n-3);

%Extracts data from output_IVP 
x0_3 = output_IVP.x3(1,:);
x1_3 = output_IVP.x3(end,:);

%for the first 3 element of G (derivatives) over x(1) 
dG_x1(1:3,1+6*(n-1):6*(n-1)+3) = eye(3,3)

%for the next 3*(n-1) elements for the boundary conditions 
for i=1:n-1
        dG_x1(3*i+1:3*i+3,6*(i-1)+1: 6*i-3) = -eye(3,3)
end

%for the boundary on p's 

for i = 1:n-1
        dG_x1(3*(n-1)+3*i+1:3*(n-1)+3*i+3,4+6*(i-1): 6*i) = -eye(3,3)
end

%for the last func
for i=1:n-1
       dG_x1(6*(n-1)+3+i:6*(n-1)+3+i,4+6*(i-1): 6*i) = [0 -cos(x0_3(i+1)) -sin(x0_3(i+1))];
end


output = dG_x1

end



