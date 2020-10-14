# SPURProject4
## 1st Week: 
### Initialize the problem: 
#### Solve the Initial Value Problem. 
- Find the solution for the IVP Problem (get two output) 
- Put all the solutions into Solve_IVP_Particles.m (maybe for the BVP Problem)
- Fixed the plot_function.m into plot_function_new.m which plot two particles and the solution for the IVP solution

## Second Week:
### Tuesday:
#### Solve IVP for n particles
- Modified diff_eqns, now it solves n particles at the same time
- It is missing a plot function for the n particles
##### - Hy - Solve IVP for n particles
- Solved n particles with length (doesn't depend on the output of previous particles) 
- Fixed Plot Function for this problem.
#### Include forces function 
- Calculate forces at every particle for a given configuration
- Calculates potential at every particle for a given configuration (not used for the forces)

### Thursday:
#### Try to solve BVP
- Create function forces that calculates forces symbolically on matlab (more efficient)
- Function error_for_BVP calculates error in boundary conditions for a given configuration (output of solve_IVP)
- diff_eqns2 and solve_IVP2 functions implemented to calculate at the same time the matrices v(t) and w(t) (from the notes)

## Third Week: 
### Tuesday: 
#### Tasks: 
- [x] Working on the matrices for derivative for dG/dx(1) and dG/dx(0) 
  - [x] dG/dx(0)
  - [x] dG/dx(1)
- [x] Working on the partial derivatives dx(1)/dx(0) and dx(1)/dlambda (Coding for the matrices) 
### Thursday: 
- Working on the error of the codes 
- Fixed the forces and make it work
## 4th Week
### Tuesday: 
- Fixed the code with the sign of the potential. 

