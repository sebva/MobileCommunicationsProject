function x = wls(base_stations, distances)
%WLS Compute the estimated position of a mobile device using WLS
%   Inputs:
%     base_stations: coordinates of known base stations, one coordinate
%       per line
%     distances: estimated distance to each base station, one per column
%   Returns the estimated x and y coordinates of the mobile device

    assert(size(base_stations, 1) == size(distances, 2));
    assert(size(base_stations, 2) == 2);
    
    % Not sure if the code is 100% n-proof, so assert size=4
    assert(size(distances, 2) == 4);

    n = size(distances, 2); % Compute alpha
    
    
    %building WLS
    [H, b] = lls_wls_base(base_stations, distances);

    %building matrix S
    S = zeros([n-1, n-1]);
    for i = 1:n-1;
        for j = 1:n-1;
            var = distances(1)^4; %Computes the variance for every distance
            if i == j;
                var = distances(1)^4 + distances(i+1)^4; %The variances for the diagonal of the matrix is different
            end;
            S(i,j) = var;
        end;
    end;
    
    x = transpose(((transpose(H) * (S \ H)) \ transpose(H)) * (S \ b));
   
end