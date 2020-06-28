function plot_function_new(output,n)

% This function creates a plot of the solution contained in the variable
% output
% Function Inputs:
%   output : structure containing the current solution
%   n : number of particles
% Function Outputs:
%   none
C = {'b-','k-','r-','g-','i-'}
D = {'.b','.k','.r','.g','.i'}
figure(1)
% Plot solution
for i=1:n

    plot(output{i}.x(:,1),output{i}.x(:,2),C{i})
    hold on
    % Plot initial condition for x at t=0
    plot(output{i}.x(1,1),output{i}.x(1,2),D{i},'MarkerSize',10)
    % Plot initial condition for x at t=L(i)
    plot(output{i}.x(end,1),output{i}.x(end,2),D{i},'MarkerSize',10)
    hold on
end
% Set axis limits
axis([-2 2 -2 2])
plot([-2 2],[0 0],'k--')
plot([0 0],[-2 2],'k--')
% Axis labels
xlabel('x_1')
ylabel('x_2')
end
