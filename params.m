% This file contains the parameters relevant for the main script in
% main_loop.m


% Estimation functions list
estimation_functions = {@lls @wls};

% Mobility patterns
mob_patterns = {@random @circle  @straight_line @square};

% Specific parameters relative to each mobility pattern
mob_patterns_parameters = {
    { 100 } % random(nb_locations)
    { 100, 200, 50, 5 } % circle(x0, y0, r, angle)
    { 200 } % linear(nb_locations)
    { } % square()
};

% Filters
filters = {0 @apply_kf};

% Coordinates of the anchor nodes
base_stations = [
    0, 0;
    0, 1000;
    1000, 1000;
    1000, 0
];

% Noise parameters
mu = 0;
sigma = 1;

% Path loss exponent (dB)
alpha = 3;

% Reference power at reference distance (dB)
P_0 = -10;

% Reference distance (m)
d_0 = 1;