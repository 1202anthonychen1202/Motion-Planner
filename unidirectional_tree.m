% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% This function creates a unidrectional tree
function [x_storage, y_storage, s, t] = unidirectional_tree(q_0, q_f, nodes, xv, yv, count_obstacles)
% Initialize variables
x_store(1) = q_0(1);
y_store(1) = q_0(2);
% Initialize variables
q = 1;
ii = 1;
jj = 1;
x_storage = [];
y_storage = [];
s = [];
t = [];
% Each time the code below loops, we get a new random pose
for n=1:nodes
    % Get a random pose
    x_current = rand(1,1)*30;
    y_current = rand(1,1)*20;
    % Find the nearest point to the current point
    for k = 1:length(x_store)
        distances(k) = dist(x_current, y_current, x_store(k), y_store(k));
    end
    [M,I] = min(distances(distances>0));
    nearest_pointx = x_store(I);
    nearest_pointy = y_store(I);
    % Plot the point if it is less than the maximum distance and collision free
    if dist(x_current,y_current,nearest_pointx, nearest_pointy) < 10 && (collision(x_current, y_current, nearest_pointx, nearest_pointy, xv, yv, count_obstacles)==0)
        % Creates s and t for highlighting shortest path
        if ~(ismember(nearest_pointx, x_storage) && ismember(nearest_pointy, y_storage))
            x_storage(ii) = nearest_pointx;
            x_storage(ii+1) = x_current;
            y_storage(ii) = nearest_pointy;
            y_storage(ii+1) = y_current;
            s(jj) = ii;
            t(jj) = ii+1;
            ii = ii+2;
            jj=jj+1;
        else
            s(jj) = find(x_storage==nearest_pointx);
            x_storage(ii) = x_current;
            y_storage(ii) = y_current;
            t(jj) = ii;
            ii = ii+1;
            jj = jj+1;
        end
        % Plot current point
        plot(x_current,y_current,'o','MarkerEdgeColor','b','MarkerFaceColor',[0,0.4470,0.7410]);
        hold on
        % Store current point for future reference to be used as nearest point
        x_store(q+1) = x_current;
        y_store(q+1) = y_current;
        q = q + 1;
        % If the current point is near the middle of the environment, break
%        if (x_current > (q_f-1) && x_current < (q_f+1)) && (y_current > (q_f-1) && y_current < (q_f+1))
%        if (x_current > (q_f-1) && x_current < (q_f+1)) && (y_current > (q_f-1) && y_current < (q_f+1))
        if (x_current > ((q_0(1)+q_f(1))/2-1) && x_current < ((q_0(1)+q_f(1))/2+1))
%             x_store(q+1) = q_f(1);
%             y_store(q+1) = q_f(2);
%             q = q + 1;
%             plot([x_current, q_f(1)], [y_current, q_f(2)]);
            % break out of for loop if a connection is able to be made to the goal
            break;
        end
    end
end
% Connects all existing nodes to prepare for finding shorest path
for i = 2:length(x_storage)-1
    for j=1:length(x_storage)-1
        if j ~= length(x_storage)
            if (collision(x_storage(j), y_storage(j), x_storage(i), y_storage(i), xv, yv, count_obstacles)==0)
                s(jj) = j;
                t(jj) = i;
                jj=jj+1;
            end
        else
            if (collision(x_storage(length(x_storage)), y_storage(length(x_storage)), x_storage(1), y_storage(1), xv, yv, count_obstacles)==0)
                s(jj) = length(x_storage);
                t(jj) = 1;
                jj=jj+1;
            end
        end
    end
end

% Remove duplicates
% z = [s; t]';
% z = unique(z, 'rows','stable');
% z(z(:,1)==z(:,2), :) = [];
% z = z';
% s = z(1,:);
% t = z(2,:);

% Highlight shortest path
highlight_path(s,t,x_storage,y_storage)