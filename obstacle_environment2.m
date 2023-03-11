% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% This function plots the obstacle environment
function [xv, yv, count_obstacles] = obstacle_environment2(filename)
% Open file
fid = fopen(filename);
% Read file
data = cell2mat(textscan(fid, '%f %f'));
% Create axis
map = binaryOccupancyMap(30,20,1);
setOccupancy(map,[data(:,1) data(:,2)], 1);
show(map)
grid on
j = 1;
width = 1;
height = 1;
count_obstacles = 0;
% Loop through data
for n = 1:(length(data(:,1)))
    count_obstacles = count_obstacles+1;
    rectangle('Position',[data(n,1)-width data(n,2)-height width height],...
        'FaceColor',[0 0 0]);
    % Convert rectangle function into vertex points
    vertices = bbox2points([data(n,1)-width data(n,2)-height width height]);
    for i = 1:length(vertices(:,1))
        xv(j) = vertices(i,1);
        yv(j) = vertices(i,2);
        j = j + 1;
    end
end