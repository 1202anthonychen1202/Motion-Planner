% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% Main Code
clear
clc
close all

% Plot the obstacle environment
[xv,yv,count_obstacles] = obstacle_environment2('Occupancy_Map_5.txt');
hold on;

% HW3 Obstacle Environment
% Note: HW3 did not use an occupancy grid so to run you would need
% obstacle_enivronment function rather than obstacle_environment2 function
% Here is the code commented out to prevent confusion:
% [xv,yv,count_obstacles] = obstacle_environment('obstacles.txt');
% hold on;

% Initial pose
q_0 = [3; 18; pi()/4];
pose_direction_plot(q_0);
% Final pose
q_f = [28; 12; pi()];
pose_direction_plot(q_f);

% Number of random poses
nodes = 1000;

% Function for unidirectional tree
[x_storage, y_storage, s, t] = unidirectional_tree(q_0, q_f, nodes, xv, yv, count_obstacles);
[x_storage_1, y_storage_1, s_1, t_1] = unidirectional_tree(q_f, q_0, nodes, xv, yv, count_obstacles);

% Connect the middle points from the two trees
% If the points collide, print out an error and message
if (collision(x_storage(length(x_storage)), y_storage(length(x_storage)), x_storage_1(length(x_storage_1)), y_storage_1(length(x_storage_1)), xv, yv, count_obstacles)==1)
    fprintf("Error: Collision detected\nRerun code \n");
% Else highlight the path that connects the two points
else
    s_final = 1;
    t_final = 2;
    x_storage_final = [x_storage(length(x_storage)) x_storage_1(length(x_storage_1))];
    y_storage_final = [y_storage(length(x_storage)) y_storage_1(length(x_storage_1))];
    highlight_path(s_final,t_final,x_storage_final,y_storage_final);
end