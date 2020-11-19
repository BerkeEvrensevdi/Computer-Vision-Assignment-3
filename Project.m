function [x2,y2] = Project(x1,y1,h)
 
%projected_point=[x1 y1 1] * h;


%disp(projected_point(1,3));

%x2 = projected_point(1,1)/projected_point(1,3);
%y2 = projected_point(1,2)/projected_point(1,3);

u = h(1,1)*x1 + h(1,2)*y1 + h(1,3)*1;
v = h(2,1)*x1 + h(2,2)*y1 + h(2,3)*1;
w = h(3,1)*x1 + h(3,2)*y1 + h(3,3)*1;

x2 = u / w;
y2 = v / w;
