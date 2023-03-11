% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% This function plots the pose direction
function pose_direction_plot(q)
plot(q(1),q(2),'o','MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5]);
q_pose = quiver(q(1),q(2),cos(q(3)), sin(q(3)));
set(q_pose,'MaxHeadSize',1e2,'AutoScaleFactor',2);
hold on
end