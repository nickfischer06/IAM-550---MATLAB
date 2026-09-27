%Nicholas Fischer | IAM 550 LAB 3
%09/22/26

%Known values
num_particles = 1000; %the number of particles in the system
x_corner = 60; %meters - starting x location for plot (bottom left corner)
y_corner = 164; %meters - starting y location for plot (bottom left corner)
range_x = 2; %meters - size of the observable plot in x direction
range_y = 2; %meters - size of the observable plot in y direction
dt = .5; %days - timestep value
D = .001; %m^2/day - Dispersion coefficient
P = .003; %1/day - change in position coefficient in velocity profile

%Init particles
%Creates the points and assgins an x and y position to all of them. The rand gives the random distribution.\
%By multiplying by the range and adding starting coordinates we can set the
%positions these particles will start at.
x = x_corner + (range_x*rand(1,(num_particles)));
y = y_corner + (range_y*rand(1,(num_particles)));

%These two variables log the x and y positions at time is zero days. They
%are to be called in the plotting later on.
x0 = x;
y0 = y;

%Init Plotting settings

%To initialize the plotting a figure window is created for the scatter
%positions at the three desired time instances. The scatter plot functions
%allow to assign x and y coordinates to points, and subplots allow for the
%three plots to be displayed next to eachother. 'hold on' and 'hold off'
%are used to layer on more plots and a second figure window later on in the
%code so everything can be displayed simultaneously.
fig1 = figure("Name", "Scatter Positions in Time");
subplot(1,3,1);
scatter(x,y,"r.");
title('Initial Particle Distribution (t = 0 days)','FontSize',14);
xlabel('X Position (meters)','FontSize',12);
ylabel('Y Position (meters)','FontSize',12);
hold on;
hold off;

%This first for loop gets the particles from their initial position to the
%position at day 50. The i range is in incriments of dt and ends at 50.
for i = 0:dt:50
    epsilon = randn(1,(num_particles)); %Gives random walk attributes to the x direction.
    eta = randn(1,(num_particles)); %Gives random walk attributes to the y direction.

    %Velocity gradient component equations
    u = P*x; %meters/day
    v = -2*P*y; %meters/day
    
    x = x + u*dt + (sqrt(2*D*dt))*epsilon; %Equations 1 and 2 as defined in the lab to predict motion
    y = y + v*dt + (sqrt(2*D*dt))*eta;
end

%Placeholder variables for x and y particles at t = 50 to be called for
%plotting.
x50 = x;
y50 = y;

%Particle position after 50 days
%The second scatter plot highlighting the position after 50 days.
subplot(1,3,2);
scatter(x,y,"g.");
title('Particle Distribution at t = 50 days','FontSize',14);
xlabel('X Position (meters)','FontSize',12);
ylabel('Y Position (meters)','FontSize',12);
hold on;


%Position to from day 50.5 to 100

%A similar for loop structure as going from t=0 to t=50. This time starting
%at 50+dt and going to 100 the starting value is set so as not to count t = 50 twice.
for i = 50+dt:dt:100
    epsilon = randn(1,(num_particles));
    eta = randn(1,(num_particles));

    %Velocity gradient component equations
    u = P*x;
    v = -2*P*y;

    x = x + u*dt + (sqrt(2*D*dt))*epsilon;
    y = y + v*dt + (sqrt(2*D*dt))*eta;
end

%Last set of placeholder variables to display particle positions after 100
%days in the desired plots.
x100 = x;
y100 = y;

%Particle Position after 100 days
%Similar subplot structure as t=0 and t=50. This shows the position of the
%points after the desired interval has passed (in this lab that was 100
%days).
subplot(1,3,3);
scatter(x,y,"b.");
title('Particle Distribution at t = 100 days','FontSize',14);
xlabel('X Position (meters)','FontSize',12);
ylabel('Y Position (meters)','FontSize',12);
hold on;

%Histogram Plotting

%A second figure window was created to keep the position scatterplots and
%histograms seperate. This chunk of code all follows the same structure by
%createing a 3 by 2 array of plots showing the distribution of the particls
%in the x and y directions. Each row corresponds to a different time (i.e
%row 1 is x at t=0 and y at t=0, row two is the same but at t=50, and so
%on). This structure allows to see particle counts as a distribution of
%position as well as how the distribution of particles changes.
fig2 = figure("Name", "Histograms at Each Time Interval");

%All subplots below follow a similar structure by defining their location
%in the array, then the plot type and of which variable and how many bins
%desired (for this lab bins = 20). Then adding titles and labels to axis in
%an appropriate font size before calling hold on so that all of them can be
%displayed together.
subplot(3,2,1);
histogram(x0,20);
title('X Position Distribution at t = 0 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

subplot(3,2,2);
histogram(y0,20);
title('Y Position Distribution at t = 0 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

subplot(3,2,3);
histogram(x50,20);
title('X Position Distribution at t = 50 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

subplot(3,2,4);
histogram(y50,20);
title('Y Position Distribution at t = 50 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

subplot(3,2,5);
histogram(x100,20);
title('X Position Distribution at t = 100 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

subplot(3,2,6);
histogram(y100,20);
title('Y Position Distribution at t = 100 days','FontSize',14);
xlabel('Position (meters)','FontSize',12);
ylabel('Frequency (count)','FontSize',12);
hold on;

%Mean and Standard Deviations at 100 days
%Find mean by using an equation and not the built in function.
x_mean = sum(x) / numel(x);
y_mean = sum(y) / numel(y);

%Checks calculated mean to built in mean in both directions before printing
%results.

%By using the if else structure the script is able to check the derived
%values from my equations above, to the actual built in function results.
%It will only display results if the calculated is within a certain margn
%of error of the actual. If that is not true an error message will be
%displayed indicating an error in calculation.
if (abs(x_mean - mean(x)) > 1e-10)
    fprintf('Error mean in the x direction does not match built in error function value');
else
    fprintf('The mean of the x particles after 100 days is %.4f\n', x_mean);
end

if (abs(y_mean - mean(y)) > 1e-10)
    fprintf('Error mean in the y direction does not match built in error function value');
else
    fprintf('The mean of the y particles after 100 days is %.4f\n', y_mean);
end

%Find variance

%This is adapted from the loop gone over in lecture on 09/17/26. By using
%the mean calculated above and the variance derived below the standard
%deviaton was found.

%Init variance vectors
x_square_sum = 0;
y_square_sum = 0; 

%Iterating through the number of elements to find the variance using the
%variance equation
for i = 1:numel(x)
    x_square_sum = x_square_sum + (x(i) - x_mean).^2;
    y_square_sum = y_square_sum + (y(i) - y_mean).^2;
end

data_varx = x_square_sum/(numel(x)-1);
data_vary = y_square_sum/(numel(y)-1);

%Finding standard deviation as the square root of the variance of each of
%the positions.
x_std = sqrt(data_varx);
y_std = sqrt(data_vary);

%Similar setup as the if else statements for the mean. These will only
%print the results if the calculated standard deviation is within a certain
%margin of error to the standard deviation of the built in function value.
%This was done as a check to make sure the calculated values are correct.

if (abs(x_std - std(x)) > 1e-10)
    fprintf('Error standard deviation in x does not match built in function\n')
else
    fprintf('The standard deviation of the x values is %.4f\n', x_std)
end

if (abs(y_std - std(y)) > 1e-10)
    fprintf('Error standard deviation in y does not match built in function\n')
else
    fprintf('The standard deviation of the y values is %.4f\n', y_std)
end
