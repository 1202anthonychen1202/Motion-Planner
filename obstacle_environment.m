% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
function [xv, yv, count_obstacles] = obstacle_environment(filename)
% Open file
fid = fopen(filename);
% Read file
data = cell2mat(textscan(fid, '%f %f %f %f %f'));
% Create axis
axis([0 30 0 20])
grid on
j = 1;
count_obstacles = 0;
% Loop through data
for n = 1:(length(data(1,:))+1)
    count_obstacles = count_obstacles+1;
    % The idea of having a first column in the text file to identify rectangle and circle is from Anthony Chen.
    % If the first column is 1, it is a rectangle
    if data(n,1) == 1
        rectangle('Position',data(n,2:end),'FaceColor',[0 0 0])
    % If the first column is 0, it is a circle
    elseif data(n,1) == 0
        rectangle('Position',data(n,2:end),'Curvature',[1 1],'FaceColor',[0 0 0])
    end
    % Convert rectangle function into vertex points
    vertices = bbox2points(data(n,2:end));
    for i = 1:length(vertices(:,1))
        xv(j) = vertices(i,1);
        yv(j) = vertices(i,2);
        j = j + 1;
    end
end