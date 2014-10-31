function[dist] = eucl_dist(x1, y1, x2, y2)
%compute euclidean distance between two points
%x1, y1 coordinates of the first point
%x2, y2 coordinates of the second point

dist = sqrt((x1-x2)^2+(y1-y2)^2);
