function [ h, b ] = lls_wls_base( base_stations, distances )
%LLS_WLS_BASE Compute matrices H and B required by the LLS and WLS
% algorithms
%   Inputs:
%     base_stations: coordinates of known base stations, one coordinate
%       per line
%     distances: estimated distance to each base station, one per column
%   Returns matrices H and B

    assert(size(base_stations, 1) == size(distances, 2));
    assert(size(base_stations, 2) == 2);
    
    n = size(distances, 2);
    b = zeros([n-1, 1]); % Preallocate the array
    h = base_stations(2:n, 1:2) * 2;

    % Compute vector b
    for i = 2:n;
        b(i-1) = (base_stations(i, 1) ^ 2) + (base_stations(i, 2) ^ 2)...
            - (distances(i) ^ 2) + (distances(1) ^ 2);
    end
end
