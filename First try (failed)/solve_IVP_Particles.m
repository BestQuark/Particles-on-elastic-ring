function output_IVP_Particles = solve_IVP_Particles(x0,p0,s,tf,params)

    %Force
    F = [1 1 0];

    %Solves with boundary conditions
    output_IVP1 = solve_IVP(x0,p0,s,params);
    output_IVP2 = solve_IVP(output_IVP1.x(end,:),output_IVP1.p(end,:)+F,tf-s,params);
    
    
    %Whole rod
    output_IVP_Particles.t = [output_IVP1.t; output_IVP2.t];
    output_IVP_Particles.x = [output_IVP1.x; output_IVP2.x];
    output_IVP_Particles.p = [output_IVP1.p; output_IVP2.p];
    
    
    
    %Position of particles
    output_IVP_Particles.P1 = output_IVP1.x(1,:) ;
    output_IVP_Particles.P2 = output_IVP1.x(end,:) ;
    
    % Store Jacobian matrices
    output_IVP_Particles.X = cat(3,output_IVP1.X, output_IVP2.X);
    output_IVP_Particles.P = cat(3,output_IVP1.P, output_IVP2.P);

    % Store values of detX and times of conjugate points
    output_IVP_Particles.detX = [output_IVP1.detX output_IVP2.detX];
    output_IVP_Particles.tconj = [output_IVP1.tconj output_IVP2.tconj];


end