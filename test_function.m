function [ errors ] = test_function( estimation_function, mobility_pattern, base_stations, mob_pattern_parameters, alpha, mu, sigma, P_0, d_0 )
%TEST_FUNCTION Test an estimation function on a specific mobility pattern
%   Test the estimation function passed in parameter as a function handle
%   with the mobility pattern also specified as a function handle.
%
%   Returns a vector containing the various amount of error in the
%   estimation of the position

    anchors_x = base_stations(:, 1);
    anchors_y = base_stations(:, 2);
    
    [ mobile_x, mobile_y ] = mobility_pattern(mob_pattern_parameters{:});
    
    nb_positions = size(mobile_x, 2);
    nb_base_stations = size(base_stations, 1);
    estimated_coord = zeros(nb_positions, 2);
    
    % for each source node compute the distance to the anchors, estimate rss,
    % estimate distance from rss, estimate coordinates using the algorithms

    for i = 1:nb_positions;
        
        %compute distances to the anchors for each source node
        dist = compute_dist(anchors_x, anchors_y, mobile_x(1,i), mobile_y(1,i));

        %estimate the rss for each source node
        rss = compute_rss(dist, set_noise(mu, sigma, nb_base_stations), alpha, P_0, d_0);

        %estimate distances to the anchor nodes based on the rss vector
        estimated_dist = estimate_dist(rss, set_noise(mu, sigma, nb_base_stations), alpha, P_0, d_0);

        %estimate the coordinates using the estimation function
        estimated_coord(i, :) = estimation_function(base_stations, estimated_dist);
    end;

    % create matrix of size (n,2) storing actual coordinates for n points
    actual_coord = horzcat(mobile_x(:), mobile_y(:));

    %compute error vector
    errors = compute_error(actual_coord, estimated_coord);    
    
end

