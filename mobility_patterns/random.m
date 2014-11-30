function [ s_x, s_y, s ] = random( nb_locations )
% RANDOM Random mobility pattern
%   Returns 2 vectors, 1st=Xs, 2nd=Ys

    s = 1;

    % vector of x coordinates of the source nodes
    s_x = randi([1,999], 1, nb_locations);
    % vector of y coordinates of the source nodes
    s_y = randi([1,999], 1, nb_locations);
end

