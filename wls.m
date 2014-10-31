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

    dstd = std(distances);
    n = size(distances, 2);
    
    % Compute alpha
    totalstd = dstd * (log(10) / (10 * (n -1)));
    
    [H, b] = lls_wls_base(base_stations, distances);

    %building WLS
    %building matrix S
    var = zeros([n, 1]);
    S = zeros([n-1, n-1]);
    e42 = exp(4 * totalstd ^ 2);
    for i = 1:n;
        var(i) = e42 * (e42 * distances(i)^4 + 1);
    end;
    for i = 1:n-1;
        for j = 1:n-1;
            S(j, i) = var(1);
            if i == j;
                S(j, i) = S(j, i) + var(i + 1);
            end;
        end;
    end;

    x = ((transpose(H) * (S \ H)) \ transpose(H)) * (S \ b);
   
end

