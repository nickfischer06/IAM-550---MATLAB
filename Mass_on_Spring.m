%IAM 550 - LAB 1
%A script by Nicholas Fischer | 09/08/2026

%For this assignment we find a spring constant and then use that value to
%practice plotting masses versus displacement.

%Constants:
g = -9.81; %gravitational constant assuming up is positve in m/s

%Solve for the spring constant:
m = 95; %mass in kg.
x_max = abs(-.1); %displacement magnitude in meters.

F_grav = m*g; %Equation for gravitational force.

k = -F_grav/x_max; %Equation for spring constant.

%fprintf('the spring constant is  kg/s');

%Plotting for a range of applied forces:

masses = [10, 25, 50, 75, 100];%masses to plot in kg.

F = masses.*g; %Force for all the masses we ant to plot in N.

x = -F/k; %equation for displacements

set(gca,'YDir','reverse', 'FontSize', 18);
plot(masses, x, 'b:*', 'LineWidth', 2);
title('Mass Versus Displacement on a Spring')
xlabel('Mass of Object (kg)');
ylabel('Displacement (m)');
legend('Hookes law solved for position: x = -F/k');
grid on;

