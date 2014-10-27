%generate 100 source nodes within the rectangle formed by the anchor nodes

% x coordinates of the source nodes
s_x = rand(1,100).*100
% y coordinates of the source nodes
s_y = rand(1,100).*100

for i = 1:4;
	base_stations(i) = [a_x(i), a_y(i)]
end;

% for each source node compute the distance to the anchors, estimate rss, estimate distance from rss, estimate coordinates using LLS

for i = 1:100;
		%compute distances to the anchors for each source node
		dist = compute_dist(a_x, a_y, s_x[i], s_y[i])
		
		%estimate the rss for each source node
		rss = compute_rss(dist, set_noise(0,1,4), alpha, P_0, d_0)
		
		%estimate distances to the anchor nodes based on the rss vector
		estimated_dist = estimate_dist(rss, noise, alpha, P_0, d_0)
		
		%estimate the coordinates using lls algorithm
		estimated_coord(i) = lls(base_stations, estimated_dist)
			
end;