% Joyce Chow, 112218043 
% Anthony Chen, 112063540
% MEC 559 Project
% This function highlights the shortest path
function highlight_path(s,t,x_storage,y_storage)
G = graph(s, t);
G = simplify(G);
[sn,tn] = findedge(G);
dx = x_storage(sn) - x_storage(tn);
dy = y_storage(sn) - y_storage(tn);
D = hypot(dx,dy);
G.Edges.Weight = D';
p = plot(G,'XData',x_storage,'YData',y_storage);
[path,d] = shortestpath(G,1,length(x_storage));
highlight(p,path,'EdgeColor','r','LineWidth',5)
end