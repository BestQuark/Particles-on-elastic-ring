function output = main_continuation_solver

% Initial conditions for x and p  
%-----------------------------------------------
% EXAMPLE: 2 PARTICLES
% one at origin, one at the top of circle
% Reqs = linspace(1/pi, 0, 50); 

x0 = [0 0 0; 0 1/pi pi];
p0 = [0 0 2*pi; 0 0 2*pi];
n = 2;
L = [0.5 0.5];
Reqs =  linspace(0.5*1/pi,0.7*1/pi,10);
% Reqs = [0.5*sqrt(2)/pi];
% Reqs =  linspace(1/pi,0,10);

% result:
% Req case1 : stretched rod
% Req case2 : squished oval
% Req case3 : decrease Req from equili to 0, but still some distance away
% note: 
% seems like any number from 0.5-0.7
% (e.g. 2/pi)works when increasing Reqs

%-----------------------------------------------
% EXAMPLE: 2 PARTICLES
% one at origin, one at the 1st quartile side of circle
% x0 = [0 0 0; 0.5/pi 0.5/pi pi/2];
% p0 = [0 0 2*pi; 0 0 2*pi];
% n = 2;
% L = [0.25 0.75];
Reqs = linspace(0.5*sqrt(2)/pi, 0.6*sqrt(2)/pi, 10);
% Reqs = linspace(1/pi, 0, 50);

% note: , the equilibrium quartile Req = 0.5*sqrt(2)/pi, particle 
% decrease Req --> move towards the origin
% increase Req --> move upward, then stretched

% refer to the 2-particles bifurcation diagram
%-----------------------------------------------
% EXAMPLE: 2 PARTICLES
%one at origin, one at the 3rd quartile side of circle
x0 = [0 0 0; -0.5/pi 0.5/pi -pi/2];
p0 = [0 0 2*pi; 0 0 2*pi];
n = 2;
L = [0.75 0.25];
% Reqs = linspace(0.5*1/pi, 1/pi, 50);

% note: decrease Req, then the equilibrium quartile 
% Req = 0.5*sqrt(2)/pi, particle moves towards the origin

% Reqs = linspace(1/pi, 0, 50);

%-----------------------------------------------

% EXAMPLE: 2 PARTICLES
% starting from Req 3
% x0 = [0 0 0; 0 0.4274 3.1416];
% p0 = [0 257.2647 22.7037; 0 -257.2647 22.7037];
% n = 2;
% L = [0.5 0.5];
% Reqs = linspace(1/pi, 0, 10);

% result: decrease Req, stretched rod goes down to get squeezed
%-----------------------------------------------

% EXAMPLE: 3 PARTICLES
% start in 3-particles-symmetric-equilateral-triangle-case
% x0 = [0 0 0; sqrt(3)/(4*pi) wrapToPi(3/(4*pi)) (2*pi)/3; 
%     -sqrt(3)/(4*pi) wrapToPi(3/(4*pi)) (4*pi)/3];
% p0 = [0 0 2*pi;0 0 2*pi;0 0 2*pi];
% n = 3;
% L = [1/3 1/3 1/3];
% Reqs =  linspace(sqrt(3)/(2*pi),0,10);

%-----------------------------------------------
% resulting is a curved squeezed "flower" image
% yet something strange occurs when increasing Reqs
% Reqs =  linspace(1/pi,0,10);

%-----------------------------------------------
% EXAMPLE: 4 PARTICLES
% start in 4-particles-symmetric-square-case
% x0 = [0 0 0;0.5/pi 0.5/pi pi/2;0 1/pi pi; -0.5/pi 0.5/pi wrapToPi(1.5*pi)];
% p0 = [0 0 2*pi; 0 0 2*pi;0 0 2*pi;0 0 2*pi];
% n = 4;
% L = [0.25 0.25 0.25 0.25];
% Reqs =  linspace(sqrt(2)/(2*pi),0,10);

%-----------------------------------------------

% EXAMPLE: 4 PARTICLES 
% NOT SYMMETRIC!!!
% randomly generated IC
% randomly generate L s.t. sumL = 1
% x0 = rand(4,3);
% p0 = 3*rand(4,3);
% n = 4;
% l1 = rand(1,1);
% l2 = rand(1,1) * (1 - l1);
% l3 = rand(1,1) * (1 - l1 - l2);
% l4 = 1 - l1 - l2 - l3;
% L = [l1 l2 l3 l4];
%-----------------------------------------------

% more eg of particles to add...

% Arclength
s = 1;

% Define parameters
params = parameters;

% List of Desired boundary condition for x(tf)
% Reqs = [0.5*sqrt(2)/pi];
% Reqs = linspace(1/pi, 0, 50);
% Reqs =  linspace(1/pi,3,50);

% Solve the continuation problem
output = solve_continuation(x0,p0,n,L,s,Reqs, params);

end