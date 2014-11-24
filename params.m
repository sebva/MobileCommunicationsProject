% This file contains the parameters relevant for the main script in
% main_loop.m


% Estimation functions list
estimation_functions = {@lls @wls};

% Mobility patterns
mob_patterns = {@random};

mob_patterns_parameters = {
    { 100 } % mob_random(nb_locations)
    };

% Colors for the resulting plots
color = {'r', 'b'};

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