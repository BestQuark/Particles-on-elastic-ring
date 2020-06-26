function plot_function(output)

% This function creates a plot of the solution contained in the variable
% output
% Function Inputs:
%   output : structure containing the current solution
%   xf : desired boundary condition for x(tf)
% Function Outputs:
%   none

figure(1)
% Plot solution
plot(output.x(:,1),output.x(:,2),'b-')

hold on

% Plot initial condition for x at t=0
%plot(output.x(1,1),output.x(1,2),'go')

plot(output.P1(1), output.P1(2), 'go')
plot(output.P2(1), output.P2(2), 'go')

% Plot desired boundary condition for x at t=tf
%plot(xf(1),xf(2),'ro')

hold off

% Set axis limits
axis([-0.5 1 -1 1])

% Axis labels
xlabel('x_1')
ylabel('x_2')

% Set axis aspect ratio
daspect([1 1 1])

% Set font size
set(gca,'FontSize',20)

% Set plot frame color to white
set(gcf,'color','w')

% Draw plot now
drawnow

% % Create ne figure
figure(2)
% 
% % Plot det(X(t)) vs t 
plot(output.t,output.detX)
% 
% hold on
% 
% % Plot horizontal line at 0
 plot([0 1],[0 0],'k--')
% 
% % Set axis limits
 axis([0 1 -max(abs(output.detX)) max(abs(output.detX))])
% 
% % Set font size
 set(gca,'FontSize',20)
% 
% % Set plot frame color to white
 set(gcf,'color','w')
% 
% % Axis labels
 xlabel('t')
 ylabel('det(X(t))')

end