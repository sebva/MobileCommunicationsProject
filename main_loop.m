%generate 100 source nodes within the rectangle formed by the anchor nodes
nb_iterations = 100;
nb_base_stations = size(a_x, 2);

% vector of x coordinates of the source nodes
s_x = randi([1,999],1,nb_iterations);
% vector of y coordinates of the source nodes
s_y = randi([1,999],1,nb_iterations);

%TODO: add coordinates for other mobility patterns, refactor code

% Estimation functions list
functions = {@lls @wls};
%Colors for the resulting plots
color = {'r', 'b'}

% create the matrix with the coordinates of the base stations to fit the input parameters of wlls and lls

for i = 1:nb_base_stations;
    base_stations(i:i,1:2) = [a_x(i), a_y(i)];  
end;

%initialise the matrices for storing the estimated coordinates
estimated_coord = cell(2);
for i = 1:size(functions, 2);
    estimated_coord{i} = zeros(nb_iterations, 2);
end;

% for each source node compute the distance to the anchors, estimate rss,
% estimate distance from rss, estimate coordinates using the algorithms

for i = 1:nb_iterations;
    %compute distances to the anchors for each source node
    dist = compute_dist(a_x, a_y, s_x(1,i), s_y(1,i));

    %estimate the rss for each source node
    rss = compute_rss(dist, set_noise(0,1,nb_base_stations), alpha, P_0, d_0);

    %estimate distances to the anchor nodes based on the rss vector
    estimated_dist = estimate_dist(rss, set_noise(0,1,nb_base_stations), alpha, P_0, d_0);

    for func_idx = 1:size(functions, 2);
        %estimate the coordinates using all algorithms
        estimated_coord{func_idx}(i, :) = functions{func_idx}(base_stations, estimated_dist);
    end;
end;

% create matrix of size (n,2) storing actual coordinates for n points
actual_coord = horzcat(s_x(:), s_y(:));


for func_idx = 1:size(functions, 2);
    %compute error vector
    error = compute_error(actual_coord, estimated_coord{func_idx});
    h = cdfplot(error);
    % not sure this should be before or after hol on, check!
    set(h,'color',color{func_idx});
    hold on
end;
