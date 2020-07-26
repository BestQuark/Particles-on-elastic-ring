function [output] = main_continuation_solver

% Initial conditions for x and p  

%EXAMPLE: TWO PARTICLES
% one at origin, one at the top of circle
% 
x0 = [0 0 0; 0 1/pi pi];
p0 = [0 0 2*pi; 0 0 2*pi];
n = 2;
L = [0.5 0.5];
% % 
% one at origin, one at the side of circle
% x0 = [0 0 0; -0.5/pi 0.5/pi -pi/2];
% p0 = [0 0 2*pi; 0 0 2*pi];
% n = 2;
% L = [0.75 0.25];

% Before biffurcation
% x0 = [ 0 0 0 ; 0.0447 0.3183 -3.1416];
% p0 = [0 0 6.2832  ; 0 0 6.2832];
% n  = 2;
% L = [0.5 0.5];


%Second biffurcation before
% x0 = [0 0 0; 0 0.1323 3.1416];
% p0 = [0.0017 -97.1177 -5.3180; -0.0017 97.1456 -5.3180];
% n = 2;
% L = [0.5 0.5];


%starting from Req 3
% x0 = [0 0 0; 0 0.4274 3.1416];
% p0 = [0 257.2647 22.7037; 0 -257.2647 22.7037];
% n=2;
% L = [0.5 0.5];



%EXAMPLE: 3 PARTICLES

%starting V1000
% x0 = [0 0 0; 0.1338 0.2316 2.0940; -0.1337 0.2317 4.1883];
% p0 = [-18.7409   37.4822  -18.7406;-32.4530   -0.0262   32.4723;4.2161    4.2182    4.2149 ]';
% n = 3;
% L = [0.3333 0.3333 0.3333];

%%starting V1000 SECOND BIFFURCATION when 3 particles look like 2 particles
% x0 = [0    0.0261   -0.0261; 0    0.1194    0.1194;0    3.2377    3.0455]';
% p0 = [-1.3637  -11.4647   -1.3662;-104.7567    0.0644  104.8861;-6.2584   -3.6914   -3.6881]';
% n = 3;
% L = [ 0.4741    0.0522    0.4737];

%EXAMPLE: 4 PARTICLES
% 
% x0 = [0 0 0;0.5/pi 0.5/pi pi/2;0 1/pi pi; -0.5/pi 0.5/pi -pi/2];
% p0 = [0 0 2*pi; 0 0 2*pi;0 0 2*pi;0 0 2*pi];
% n = 4;
% L = [0.25 0.25 0.25 0.25];

%  x0 = [0 0 0;0.0711 0.0711 1.5708;0 0.1421 3.1416;-0.0711 0.0711 -1.5708];
%  p0 = [-426.4207 -426.4572 -28.2936; 426.4537 -426.4416 -28.2942 ;...
%      426.4406 426.4527 -28.2936;-426.4736 426.4371 -28.2931];
%  n = 4;
%  L = [0.25 0.25 0.25 0.25];
%  



%EXAMPLE: 5 PARTICLES
% 3 on side Req = 0.1 V=100
% x0 = [0 0 0;...
%     0.1805 0.1895 1.6195;...
%     -0.0268 0.2786 3.8301;...
%     -0.0650 0.2427 3.9513;...
%     -0.0990 0.2028 4.0726];
% p0 = [-36.9349 -38.7781 3.2393;...
%     73.9702 -33.3751 3.2393 ;...
%     41.1433 6.5197 2.9067...
%     ;4.5095 41.4117 1.6782;...
%     -36.9357 72.2580 2.9067];
% n = 5;
% L = [0.2989    0.2981    0.0525    0.0525    0.2981];


% % Eq 5 particles
% x0 = [0 0 0;...
%     0.15136 0.10997 2*pi/5;...
%     0.0935489 0.287913 4*pi/5;...
%     -0.0935489 0.287913 3*2*pi/5;...
%     -0.15136 0.10997 4*2*pi/5];
% p0 = [-0.0797 -0.5000 6.2452;...
%     0.0456 -0.2420 6.2793 ;...
%     0.5388 -0.1006 6.2751;...
%     0.0679 0.1128 6.2812;...
%    -0.2293 0.0576 6.2756];
% n = 5;
% L = [0.2    0.2    0.2    0.2    0.2];


% Arclength
s = 1;

% Define parameters
params = parameters;

% List of Desired boundary condition for x(tf)

%Reqs = linspace( 0.5*sqrt(2)/pi,1/pi,20);


Reqs =  linspace(1/pi,0,20);

%First biffurcation for 2 particles
%Reqs = linspace(0.316,0,30);

%Second biffurcation for 2 particles
%Reqs = linspace(0.08, 0,15);

%Reqs = 0.5*sqrt(2)/pi;

%Reqs = 0.2739;
%Reqs = linspace(0.1,0.3,10);
%3 particles FIRST BIFFURCATION
%Reqs = linspace(0.2487,0, 30);

%3 Particles SECOND BIFFURCATION
%Reqs = linspace(0.0686,0,20);


%5 particles eq
%Reqs = 0.1870916;


%Starting before biffurcation
%Reqs =  linspace(0.3150950308, 0.5*sqrt(2)/pi, 30);

%Vos = linspace(0,6.5,30);  
Vos = 2000;
% Solve the continuation problem
[output] = solve_continuation(x0,p0,n,L,s,Reqs, Vos, params);

% REQSPLOT = zeros(1,length(Vos));
% plots = zeros(length(Vos),2);
% for i=1:length(Vos)
%    [output, Out_Req]= find_det0_moveReq(x0,p0,n,L,s,Reqs, Vos(i), params);
%     REQSPLOT(i)=Out_Req;
%     Reqs = Out_Req;
%     plot(Out_Req,Vos(i),'.b')
%     i
% end
% plot(REQSPLOT,Vos,'.b')
% xlabel('R_e_q');
% ylabel('Magnitude');
% 
% plots(:,1) = REQSPLOT;
% plots(:,2) = Vos;


end