function x = lls( base_stations, distances )
%LLS Compute the estimated position of a mobile device using LLS
%   Inputs:
%     base_stations: coordinates of known base stations, one coordinate
%       per line
%     distances: estimated distance to each base station, one per column
%   Returns the estimated x and y coordinates of the mobile device

    assert(size(base_stations, 1) == size(distances, 2));
    assert(size(base_stations, 2) == 2);
    
    [h, b] = lls_wls_base(base_stations, distances);
    
    ht = transpose(h);
    
    % Compute the estimated location relative to base_station 1 and
    % translate in absolute coordinates.
    % Note: ht * h \ ht is equivalent to inv(ht * h) * ht
    x = transpose(((ht * h) \ ht) * b) + base_stations(1, 1:2);
end

