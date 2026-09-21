%IAM 550 LAB02 - Howitzer Launch
%By Nicholas Fischer | 09/15/2026

clear
clc

%Known values
g = 9.81; %(m/s)
v1 = 585; %(m/s)
cannonDist = 1000; %(m) from base of mountain
max_elev = 3216; %(m)
cannon_elev = 2600; %(m)
hLaunch = 1; %(m)
theta = [10, 12, 14, 17]; %(deg)
t = linspace(0,10,1000); %time parameters


%Plot Physical Setup. This gets you the height of the mountain as well as
%the overall shape of the mountain we are trying to hit in a 2D plane.
hMountain = max_elev - cannon_elev; %(m)
lMountain = (hMountain/tand(theta(4))); %(m)
x3 = lMountain + cannonDist; 

xGeo = [0,cannonDist,x3]; %x-coordinates of the mountain
yGeo = [0, 0, hMountain]; %y-coordinates of the mountain

figure
plot(xGeo, yGeo, Linewidth=3)
xlabel('Horizontal Distance (m)', FontSize=13);
ylabel('Vertical Distance (m)', FontSize=13);
grid on;

hold on;

%Plot Trajectories
%Because we are testing multiple different firing angles for the cannon,
%and wish to plot them all on the same plot I elected to use a for loop to
%minimize the code length and cut down on repetitive tasks. This loops
%through the vector theta for all the different firing angles.
for i = 1:3
    thetaPlot = theta(i);
    x = (v1.*cosd(thetaPlot)).*t; %x position equation
    y = (v1*sind(thetaPlot)).*t - (0.5.*g.*(t).^2) + hLaunch; %y position equation
    
    %Figuring out where each projectile hits
    %This is a neat bit of code I developed to find the intersection points
    %of the graphs on the mountain surface. 
    groundUnder = zeros(size(x)); %Initialize a ground under vector to be filled as t progresses, but this is done so that the vector does not blow up and get too large.
    onSlope = x > cannonDist; %allows me to distinguish whether x is acutally on the mountain slope or still on the horizontal portion.
    groundUnder(onSlope) = tand(theta(4)) * (x(onSlope) - cannonDist); %This is vector math seeing if the point in the x direction is on the slope of the mountain or still on the horizontal portion.
    
    hit = find(y <= groundUnder, 1, "first");
    %The hit variable finds where the ground under value hits the mountain in the y direction. "first" denotes first instance this occurs. 
    
    %This if loop says that if the trajectory hits the mountain x and y are
    %assigned to be the function x from the starting position to the
    %position where it hit.
    if ~isempty(hit)
        x = x(1:hit);
        y = y(1:hit);
    end
    %Now we loop through plotting the x and y functions for the
    %trajectory.
    plot(x,y, "--", Linewidth=2)
    hold on;
    plot(x(hit), y(hit), '*', LineWidth=3)
    title('Horizontal and Vertical Impact Points of Howitzer Projectile Launch', FontSize=14)
    legend('Geography', 'Trajectory 1 (theta = 10 deg)', 'Impact point 1', 'Trajectory 2 (theta = 12 deg)', 'Impact point 2', 'Trajectory 3 (theta = 14 deg)', 'Impact Point 3', Location='southeast', FontSize=12);
end


