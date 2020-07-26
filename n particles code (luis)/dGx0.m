function output = dGx0(output_IVP,n,forces)

dF =forces.A;
%calculate dG/dx0
dG_x0 = zeros(7*n-3,6*n-3);
%calculate dG/dx1

%Extracts data from output_IVP 
x0_3 = output_IVP.x3(1,:);

p0_1 = output_IVP.p1(1,:);
p0_2 = output_IVP.p2(1,:);
pf_1 = output_IVP.p1(end,:);
pf_2 = output_IVP.p2(end,:);

%for the next 3*(n-1) elements for the boundary conditions 
for i=1:n-1
        dG_x0( 4+3*(i-1):6+3*(i-1), 4+6*(i-1):6+6*(i-1)) = eye(3,3);
end

%for the boundary on p's (6n-3)
    
for i = 2:n
        dG_x0(3*n+1+3*(i-2) : 3*n+3+3*(i-2),1+6*(i-1):3+6*(i-1)) = eye(3,3);
        
        for j = 2:n
            dG_x0(3*n+1+3*(i-2),4+6*(j-2):6+6*(j-2) ) = -[dF(2*(i-1)+1,2*(j-1)+1) dF(2*(i-1)+1,2*j) 0];
            dG_x0(3*n+2+3*(i-2),4+6*(j-2):6+6*(j-2)) = -[dF(2*i,2*(j-1)+1) dF(2*i,2*j) 0]  ;          
        end 
end


%for the last func (n-1)
for i=1:n-1
    %dP
       dG_x0(6*n-3+i,1+6*i:3+6*i) = [cos(x0_3(i+1)) sin(x0_3(i+1)) 0];
     %dx
      dG_x0(6*n-3+i,6*i) = sin(x0_3(i+1))*(-p0_1(i+1)+pf_1(i)) +cos(x0_3(i+1))*(-pf_2(i)+p0_2(i+1)) ;
end


output = dG_x0;

end

