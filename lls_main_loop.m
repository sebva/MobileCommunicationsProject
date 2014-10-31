%generate 100 source nodes within the rectangle formed by the anchor nodes

% vector of x coordinates of the source nodes
s_x = randi([1,999],1,100);
% vector of y coordinates of the source nodes
s_y = randi([1,999],1,100);

% create the matrix with the coordinates of the base stations to fit the input parameters of wlls and lls

for i = 1:4;
  base_stations(i:i,1:2) = [a_x(i), a_y(i)];  
end;

%initialise the matrices for storing the estimated coordinates
lls_estimated_coord = zeros(100,2);
wls_estimated_coord = zeros(100,2);

% for each source node compute the distance to the anchors, estimate rss, estimate distance from rss, estimate coordinates using LLS

for i = 1:100;

		%compute distances to the anchors for each source node
		dist = compute_dist(a_x, a_y, s_x(1,i), s_y(1,i));
		
		%estimate the rss for each source node
		rss = compute_rss(dist, set_noise(0,1,4), alpha, P_0, d_0);
		
		%estimate distances to the anchor nodes based on the rss vector
		estimated_dist = estimate_dist(rss, set_noise(0,1,4), alpha, P_0, d_0);
		
		%estimate the coordinates using lls algorithm
		lls_estimated_coord(i:i,1:2)  = lls(base_stations, estimated_dist);
        
			
end;

% create matrix of size (n,2) storing actual coordinates for n points
actual_coord = horzcat(s_x(:), s_y(:));
%compute error vector
error = compute_error(actual_coord, lls_estimated_coord);

cdfplot(error);

