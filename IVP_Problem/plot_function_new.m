function plot_function_new(output1,output2,xf1,xf2)

% This function creates a plot of the solution contained in the variable
% output
% Function Inputs:
%   output : structure containing the current solution
%   xf : desired boundary condition for x(tf)
% Function Outputs:
%   none
figure(1)
% Plot solution
%plot(output1.x(:,1),output1.x(:,2),'b-')
plot(output1.x(:,1), output1.x(:,2),output2.x(:,1), output2.x(:,2));
%plot(output.t(:,1),output.detX(:,2))

hold on

% Plot initial condition for x at t=0
plot(output1.x(1,1),output1.x(1,2),'.k','MarkerSize',10)

% Plot desired boundary condition for x at t=tf
plot(output2.x(1,1),output2.x(1,2),'.k','MarkerSize',10)

hold on

% Set axis limits
axis([-0.5 0.5 -0.5 0.5])
plot([-1 1],[0 0],'k--')
plot([0 0],[-1 1],'k--')
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

%%Create ne figure
figure(2)
% 
% % Plot det(X(t)) vs t 
plot(output1.t,output1.detX)
% 
hold on
% 
% % Plot horizontal line at 0
plot([0 1],[0 0],'k--')
% 
% % Set axis limits
axis([0 1 -max(abs(output1.detX)) max(abs(output1.detX))])
% 
% % Set font size
set(gca,'FontSize',20)
% 
% % Set plot frame color to white
set(gcf,'color','w')
% 
% % Axis labels
xlabel('t')
ylabel('det(X1(t))')

%%Create ne figure
figure(3)
% 
% % Plot det(X(t)) vs t 
plot(output2.t,output2.detX)
% 
hold on
% 
% % Plot horizontal line at 0
plot([0 1],[0 0],'k--')
% 
% % Set axis limits
axis([0 1 -max(abs(output2.detX)) max(abs(output2.detX))])
% 
% % Set font size
set(gca,'FontSize',20)
% 
% % Set plot frame color to white
set(gcf,'color','w')
% 
% % Axis labels
xlabel('t')
ylabel('det(X2(t))')
end