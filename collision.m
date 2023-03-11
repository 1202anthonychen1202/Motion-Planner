% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% This function determines if a path collides with an obstacle
% Reference: StackOverflow
function [intersect] = collision(x_current, y_current, nearest_pointx, nearest_pointy, xv, yv, count_obstacles)
% Every 4 rows is its own shape
for q = 1:4:(4*count_obstacles)    
    % Loop through the four vertices of the shape
    for n = q:q+3
        % If statement is used to connect the last point to the first point
        if (n+1)>(q+3)
            xv_start = xv(n);
            yv_start = yv(n);
            xv_end = xv(q);
            yv_end = yv(q);
        else
            xv_start = xv(n);
            yv_start = yv(n);
            xv_end = xv(n+1);
            yv_end = yv(n+1);
        end
        
        % Check if the lines intersect. Reference for line 22 to 31: Stack Overflow
        x=[x_current nearest_pointx xv_start xv_end];
        y=[y_current nearest_pointy yv_start yv_end];
        dt1=det([1,1,1;x(1),x(2),x(3);y(1),y(2),y(3)])*det([1,1,1;x(1),x(2),x(4);y(1),y(2),y(4)]);
        dt2=det([1,1,1;x(1),x(3),x(4);y(1),y(3),y(4)])*det([1,1,1;x(2),x(3),x(4);y(2),y(3),y(4)]);
        % If lines intersect, return 1
        if(dt1<=0 && dt2<=0)
            intersect=1;
            break;
        % If not, return 0
        else
            intersect=0;
        end
    end
    if intersect==1
        break;
    end
end