function plot_function(output,n)

% This function creates a plot of the solution contained in the variable
% output
% Function Inputs:
%   output : structure containing the current solution
%   n : number of particles
% Function Outputs:
%   none
C = {'b-','k-','r-','g-','i-'};
D = {'.b','.k','.r','.g','.i'};
figure(1)
% Plot solution
for i=1:n
    plot(output.x1(:,i),output.x2(:,i),C{i})
    hold on
    % Plot initial condition for x at t=0
    plot(output.x1(1,i),output.x2(1,i),D{i},'MarkerSize',10)
    % Plot initial condition for x at t=L(i)
    plot(output.x1(end,i),output.x2(end,i),D{i},'MarkerSize',10)
end

% Set axis limits
axis([-2 2 -2 2])
plot([-2 2],[0 0],'k--')
plot([0 0],[-2 2],'k--')
% Axis labels
xlabel('x_1')
ylabel('x_2')

hold off

end
